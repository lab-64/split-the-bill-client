import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/bill_suggestion.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';

part 'controllers.g.dart';

@riverpod
class EditBillController extends _$EditBillController {
  late String _name;
  late DateTime _date;

  @override
  FutureOr<void> build() async {
    _name = '';
    _date = DateTime.now();
  }

  void setName(String name) => _name = name;

  void setDate(DateTime date) => _date = date;

  Future<void> addBill(String groupId) async {
    state = const AsyncLoading();
    final user = ref.watch(authStateProvider).requireValue;
    final items = ref.read(itemsProvider('0'));

    final bill = Bill(
      id: '',
      name: _name == '' ? items.first.name : _name,
      groupId: groupId,
      owner: user,
      date: _date,
      items: items,
      balance: {},
      isViewed: true,
      updatedAt: DateTime.now()
    );

    for (var item in bill.items) {
      if (item.name == "" || item.price == 0.0) {
        state = AsyncError(
            "Please give all items a name and a price other than 0.0€!",
            StackTrace.current);
        return;
      }
    }

    final billsState = ref.read(billsStateProvider().notifier);
    state = await AsyncValue.guard(() => billsState.create(bill));
  }

  Future<void> editBill(String billId) async {
    state = const AsyncLoading();

    final bill = ref.read(billStateProvider(billId));
    final items = ref.read(itemsProvider(billId));

    Bill updatedBill = bill.requireValue.copyWith(
      name: _name,
      date: _date,
      items: items,
      updatedAt: DateTime.now()
    );

    final billsState = ref.read(billsStateProvider().notifier);
    state = await AsyncValue.guard(() => billsState.edit(updatedBill));
  }
}

@riverpod
class Items extends _$Items {
  @override
  List<Item> build(String billId) {
    return ref.read(billStateProvider(billId)).requireValue.items;
  }

  void addItem(Item item, String billId) {
    if (billId != '0') {
      item = item.copyWith(billId: billId);
    }
    state = [...state, item];
  }

  void updateItem(
    int index,
    String name,
    String price,
    List<User> contributors,
  ) {
    state[index] = state[index].copyWith(
      name: name,
      price: price.isEmpty ? 0 : double.parse(price),
      contributors: contributors,
    );
  }

  void setItemsFromSuggestion(BillSuggestion billSuggestion) {
    final names = billSuggestion.nameList;
    final prices = billSuggestion.priceList;

    List<Item> items = List.generate(
      names.length,
      (index) => Item.getDefault().copyWith(
        name: names[index],
        price: prices[index],
      ),
    ).where((item) => item.name.isNotEmpty || item.price != 0).toList();

    state = items;
  }

  void removeItem(int index) {
    state.removeAt(index);
  }
}

@riverpod
class BillRecognition extends _$BillRecognition {
  @override
  Future<BillSuggestion> build() {
    return Future.value(const BillSuggestion(nameList: [], priceList: []));
  }

  Future<void> runBillRecognition(XFile? image) async {
    state = const AsyncLoading();

    if (image == null) {
      state = AsyncError("No image selected", StackTrace.current);
      return;
    }

    File imageFile = File(image.path);

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final InputImage inputImage = InputImage.fromFile(imageFile);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    textRecognizer.close();

    // get image properties
    ui.Image img = await decodeImageFromList(imageFile.readAsBytesSync());
    int imageWidth = img.width;

    // block lists
    List<String> nameList = [];
    List<double> priceList = [];

    RegExp priceExp = RegExp(r"\b\d+(?:,\s?\d+)?(?:\.\d+)?\b");
    // add all lines from the blocks to the related list
    for (int i = 0; i < recognizedText.blocks.length; i++) {
      int blockX = recognizedText.blocks[i].cornerPoints[0].x;
      if (blockX < imageWidth / 2) {
        for (TextLine line in recognizedText.blocks[i].lines) {
          nameList.add(line.text);
        }
      } else {
        // price case
        for (TextLine line in recognizedText.blocks[i].lines) {
          // check if line contains a number
          if (priceExp.hasMatch(line.text)) {
            // Remove letters from the string
            String cleanedString =
                line.text.replaceAll(RegExp(r'[^0-9,.-]'), '');
            // Replacing the comma with a dot and removing spaces
            String numberString =
                cleanedString.replaceAll(',', '.').replaceAll(' ', '');
            // Convert to a double
            try {
              double result = double.parse(numberString);
              priceList.add(result);
            } catch (e) {
              debugPrint("Error: $e, ${line.text}");
            }
          }
        }
      }
    }

    // fill the shorter list with empty strings or zeros
    _fillLists(nameList, priceList);
    state = AsyncData(BillSuggestion(nameList: nameList, priceList: priceList));
  }

  void _fillLists(List<String> itemList, List<double> priceList) {
    int lengthDifference = itemList.length - priceList.length;

    if (lengthDifference > 0) {
      // itemList is longer, fill priceList with zeros
      priceList.addAll(List<double>.filled(lengthDifference, 0));
    } else if (lengthDifference < 0) {
      // priceList is longer, fill itemList with empty strings
      itemList.addAll(List<String>.filled(-lengthDifference, ''));
    }
  }
}

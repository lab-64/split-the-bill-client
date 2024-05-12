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

@Riverpod(keepAlive: true)
class EditBillController extends _$EditBillController {
  @override
  FutureOr<void> build() async {}

  Future<void> addBill(String groupId) async {
    state = const AsyncLoading();
    final user = ref.watch(authStateProvider).requireValue;
    final items = ref.read(itemsProvider('0'));

    final bill = Bill(
      id: '',
      name: items.first.name,
      groupId: groupId,
      owner: user,
      date: DateTime.now(),
      items: items,
      balance: {},
      isViewed: true,
    );

    if (bill.name.isEmpty) {
      state =
          AsyncError("Please give the first item a name", StackTrace.current);
    } else {
      final billsState = ref.read(billsStateProvider().notifier);
      state = await AsyncValue.guard(() => billsState.create(bill));
    }
  }

  Future<void> editBill(Bill bill, List<Item> items) async {
    state = const AsyncLoading();
    Bill updatedBill = bill.copyWith(items: items);

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

  void addItem(Item item) {
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

  void removeItem(int index) {
    state.removeAt(index);
  }
}

@riverpod
class BillRecognition extends _$BillRecognition {
  @override
  Future<BillSuggestion> build() {
    return Future.value(const BillSuggestion(itemList: [], priceList: []));
  }

  void runBillRecognition(XFile? image) async {
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
    List<String> itemList = [];
    List<double> priceList = [];

    RegExp priceExp = RegExp(r"\b\d+(?:,\s?\d+)?(?:\.\d+)?\b");
    // add all lines from the blocks to the related list
    for (int i = 0; i < recognizedText.blocks.length; i++) {
      int blockX = recognizedText.blocks[i].cornerPoints[0].x;
      if (blockX < imageWidth / 2) {
        for (TextLine line in recognizedText.blocks[i].lines) {
          itemList.add(line.text);
        }
      } else {
        // price case
        for (TextLine line in recognizedText.blocks[i].lines) {
          // check if line contains a number
          if (priceExp.hasMatch(line.text)) {
            // Remove letters from the string
            String cleanedString =
                line.text.replaceAll(RegExp(r'[^0-9,.]'), '');
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

    state = AsyncData(BillSuggestion(itemList: itemList, priceList: priceList));
  }
}

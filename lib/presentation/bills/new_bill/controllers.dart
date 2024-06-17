import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/domain/bill/bill_suggestion.dart';
import 'package:split_the_bill/domain/bill/item.dart';
import 'package:split_the_bill/domain/bill/states/bill_state.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';

import '../../../auth/user.dart';

part 'controllers.g.dart';

@riverpod
class UpsertBillController extends _$UpsertBillController {
  @override
  FutureOr<void> build() async {}

  Future<void> addBill(String groupId) async {
    state = const AsyncLoading();
    final user = ref.watch(authStateProvider).requireValue;
    var bill = ref.read(editBillControllerProvider);

    bill = bill.copyWith(
      id: '',
      owner: user,
      groupId: groupId,
      balance: {},
      isViewed: true,
      updatedAt: DateTime.now(),
    );

    final billsState = ref.read(billsStateProvider().notifier);
    state = await AsyncValue.guard(() => billsState.create(bill));
  }

  Future<void> editBill(String billId) async {
    state = const AsyncLoading();
    var bill = ref.read(editBillControllerProvider);
    final billsState = ref.read(billsStateProvider().notifier);
    state = await AsyncValue.guard(() => billsState.edit(bill));
  }
}

@riverpod
class EditBillController extends _$EditBillController {
  @override
  Bill build() {
    Bill bill = Bill.getDefault();
    bill = bill.copyWith(owner: ref.read(authStateProvider).requireValue);
    return bill;
  }

  void setBill(String billId) {
    final bill = ref.watch(billStateProvider(billId));
    state = bill.requireValue;
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  void addItem(Item item) {
    state = state.copyWith(items: [...state.items, item]);
  }

  void setContributors(List<User> contributors) {
    List<Item> updatedItems = [];
    for (var item in state.items) {
      updatedItems.add(item.copyWith(contributors: contributors));
    }

    state = state.copyWith(items: updatedItems);
  }

  void updateItem(int index, Item item) {
    state = state.copyWith(items: [
      ...state.items.sublist(0, index),
      item,
      ...state.items.sublist(index + 1),
    ]);
  }

  void removeItem(int index) {
    state = state.copyWith(items: [
      ...state.items.sublist(0, index),
      ...state.items.sublist(index + 1),
    ]);
  }

  void setItemsFromSuggestion(BillSuggestion billSuggestion) {
    final names = billSuggestion.nameList;
    final prices = billSuggestion.priceList;

    final listLength = max(names.length, prices.length);
    List<Item> items = [];

    for (var i = 0; i < listLength; i++) {
      items.add(Item.getDefault().copyWith(
        name: names.length <= i || names[i] == '' ? "Item $i" : names[i],
        price: prices.length <= i ? 0 : prices[i],
      ));
    }

    state = state.copyWith(items: items);
  }
}

@riverpod
class BillRecognition extends _$BillRecognition {
  @override
  Future<BillSuggestion> build() {
    return Future.value(const BillSuggestion(nameList: [], priceList: []));
  }

  Future<void> runBillRecognition(Uint8List image) async {
    state = const AsyncLoading();

    if (image.isEmpty) {
      state = AsyncError("Could not process image", StackTrace.current);
      return;
    }

    try {
      ui.Image img = await decodeImageFromList(image);

      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.latin);

      final dir = await getTemporaryDirectory();
      File imgFile = File("${dir.path}/cropped.jpeg");
      imgFile.writeAsBytesSync(image, flush: true, mode: FileMode.writeOnly);
      final InputImage inputImage = InputImage.fromFile(imgFile);
      // log("Success");
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      textRecognizer.close();

      // get image properties
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
      state =
          AsyncData(BillSuggestion(nameList: nameList, priceList: priceList));
    } catch (e, stackTrace) {
      state = AsyncError(e.toString(), stackTrace);
    }
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

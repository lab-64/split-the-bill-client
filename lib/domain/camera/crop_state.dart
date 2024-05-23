
import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'crop_state.g.dart';

@riverpod
class CroppingState extends _$CroppingState {
  @override
  Uint8List build() {
    return Uint8List(0);
  }

  void setCroppedImage(Uint8List image) {
    state = Uint8List.fromList(image);
  }
}

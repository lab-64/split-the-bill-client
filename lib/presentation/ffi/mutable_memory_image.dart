
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MutableMemoryImage extends ImageProvider<MutableMemoryImage> {
  MutableMemoryImage(this.bytes);

  Uint8List bytes;

  @override
  Future<MutableMemoryImage> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<MutableMemoryImage>(this);
  }

  
}
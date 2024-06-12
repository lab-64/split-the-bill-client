import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

class ImageUtils {
  static Future<ui.Image> createImageFromFile(String path) async {
    Uint8List byteList = await File(path).readAsBytes();
    ui.Codec codec = await ui.instantiateImageCodec(byteList);
    return (await codec.getNextFrame()).image;
  }
}

import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

class ImageUtils {

  static Future<ui.Image> createImageFromFile(String path) async {
    Uint8List byteList = await File(path).readAsBytes();
    ui.Codec codec = await ui.instantiateImageCodec(byteList);
    return (await codec.getNextFrame()).image;
  }

  static Future<ui.Image> cropImageFromFile(String filePath, List<Offset> cropPath, double scalingFactor) async {
    ui.Image img = await createImageFromFile(filePath);
    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    Path path = Path();
    path.addPolygon(cropPath, true);
    path.close();
    canvas.clipPath(path);
    canvas.drawImage(img, Offset.zero, Paint());

    double maxY = cropPath.map((p) => p.dy).reduce(max);
    double minY = cropPath.map((p) => p.dy).reduce(min);
    double maxX = cropPath.map((p) => p.dx).reduce(max);
    double minX = cropPath.map((p) => p.dx).reduce(min);

    int imgWidth = ((maxX - minX) * scalingFactor).toInt();
    int imgHeight = ((maxY - minY) * scalingFactor).toInt();

    ui.Image croppedImg = await recorder.endRecording().toImage(imgWidth, imgHeight);
    return croppedImg;
  }

}


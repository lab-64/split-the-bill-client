import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split_the_bill/infrastructure/edge_detection/edge_detection_result.dart';

class ImageUtils {

  static Future<ui.Image> createImageFromFile(String path) async {
    Uint8List byteList = await File(path).readAsBytes();
    ui.Codec codec = await ui.instantiateImageCodec(byteList);
    return (await codec.getNextFrame()).image;
  }


  static Future<void> saveImageToFile(ui.Image img, String path) async {
    final ByteData? imgBytes = await img.toByteData();
    final Uint8List imgByteList = imgBytes!.buffer.asUint8List();
    final File file = File(path);
    file.writeAsBytes(imgByteList);
  }

  static Future<ui.Image> cropImageFromFile(String filePath, DetectedRectangle cropPath) async {
    ui.Image img = await createImageFromFile(filePath);

    List<Offset> cropPoints = [
      cropPath.topLeft,
      cropPath.topRight,
      cropPath.bottomRight,
      cropPath.bottomLeft,
      cropPath.topLeft
    ];

    cropPoints = cropPoints.map((e) {
      return Offset(e.dx * img.width, e.dy * img.height);
    }).toList();
    

    ui.PictureRecorder recorder = ui.PictureRecorder();
    Canvas canvas = Canvas(recorder);
    Path path = Path();
    path.addPolygon(cropPoints, true);
    path.close();
    canvas.clipPath(path);
    canvas.drawImage(img, Offset.zero, Paint());

    double maxY = cropPoints.map((p) => p.dy).reduce(max);
    double minY = cropPoints.map((p) => p.dy).reduce(min);
    double maxX = cropPoints.map((p) => p.dx).reduce(max);
    double minX = cropPoints.map((p) => p.dx).reduce(min);

    int imgWidth = (maxX - minX).toInt();
    int imgHeight = (maxY - minY).toInt();

    ui.Image croppedImg = await recorder.endRecording().toImage(imgWidth, imgHeight);
    return croppedImg;
  }

}

class ImageScreen extends StatelessWidget {
  const ImageScreen({super.key, required this.image});

  final ui.Image image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: image.toByteData(),
        builder: (BuildContext context, AsyncSnapshot<ByteData?> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Uint8List bytes = snapshot.data!.buffer.asUint8List();
            return Image.memory(bytes);
          }
          return const CircularProgressIndicator();
      },
      )
    );
  }

}


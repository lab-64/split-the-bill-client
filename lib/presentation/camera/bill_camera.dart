
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/camera/image_util.dart';
import 'package:split_the_bill/presentation/camera/img_view.dart';
import 'package:split_the_bill/presentation/camera/rect_selection_screen.dart';
import 'package:split_the_bill/presentation/ffi/edge_detection.dart';
import 'package:image/image.dart' as imglib;

class CameraPage extends StatefulWidget {
  const CameraPage({
    super.key,
    required this.cameras
  });

  final List<CameraDescription> cameras;

  @override
  State<StatefulWidget> createState() => CameraPageState();

}

class CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int currentCamera = 0;
  DetectedRect? detectedRect;
  Size imageSize = const Size(0,0);


  @override
  void initState() {
     super.initState();

     _controller = CameraController(
       widget.cameras[currentCamera],
       ResolutionPreset.low,
       enableAudio: false,
     );
     _initializeControllerFuture = _controller.initialize();

     _initializeControllerFuture.then((value) {
       _controller.startImageStream((image) async {
           // imageSize = Size(image.width.roundToDouble(), image.height.roundToDouble());
           // Uint8List yLane = image.planes[0].bytes;
           // var uvLane = BytesBuilder();
           // for (int i = 1; i < image.planes.length; ++i) {
           //   uvLane.add(image.planes[i].bytes);
           // }
           // print("y: ${image.planes[0].bytes.length}, || u: ${image.planes[2].bytes.length}");
         imglib.Image rgbImage = ImageUtilities.convertYUV420toImage(image);
         Navigator.push(context,
             MaterialPageRoute(builder: (_) => ImageView(img: rgbImage)));
         //detectedRect = RectDetection.detectRect(rgbImage.buffer.asUint8List());
       });
     });
  }

  @override
  void dispose() {
    _controller.stopImageStream();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        ),
       CustomPaint(
         size: imageSize,
         painter: RectangleSelection(
           rect: detectedRect,
           imgSize: imageSize,
           color: CupertinoColors.systemGreen
         )
       )
      ]
    );
  }



  Future<Uint8List?> convertYUV420toImageColor(CameraImage image) async {
    const shift = (0xFF << 24);
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int uvPixelStride = image.planes[1].bytesPerPixel!;

      print("uvRowStride: $uvRowStride");
      print("uvPixelStride: $uvPixelStride");

      // imgLib -> Image package from https://pub.dartlang.org/packages/image
      var img = imglib.Image(height: height, width: width); // Create Image buffer

      // Fill image buffer with plane[0] from YUV420_888
      for(int x=0; x < width; x++) {
        for(int y=0; y < height; y++) {
          final int uvIndex = uvPixelStride * (x/2).floor() + uvRowStride*(y/2).floor();
          final int index = y * width + x;

          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];
          // Calculate pixel color
          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 -vp * 93604 / 131072 + 91).round().clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          img.setPixelRgba(height-y, x, r , g ,b ,shift);

        }
      }

      imglib.PngEncoder pngEncoder = imglib.PngEncoder(level: 0);
      Uint8List png = pngEncoder.encode(img);
      return png;
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:$e");
    }
    return null;
  }
  
}
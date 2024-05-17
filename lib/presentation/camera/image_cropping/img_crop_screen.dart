import 'dart:io';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:split_the_bill/infrastructure/edge_detection/edge_detection_result.dart';
import 'package:split_the_bill/infrastructure/image_processing/image_utils.dart';
import 'package:split_the_bill/presentation/camera/image_cropping/crop_rectangle.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';

class ImageCropScreen extends StatefulWidget {
  const ImageCropScreen({super.key, required this.imgFile});

  final String imgFile;

  @override
  State<StatefulWidget> createState() {
    return _ImageCropScreenState();
  }
}

class _ImageCropScreenState extends State<ImageCropScreen> {
  GlobalKey imageKey = GlobalKey();
  late File currentImageFile;

  @override
  void initState() {
    currentImageFile = File(widget.imgFile);
    super.initState();
  }


  DetectedRectangle cropPath = DetectedRectangle(
      topLeft: const Offset(0.2, 0.2),
      topRight: const Offset(0.8, 0.2),
      bottomLeft: const Offset(0.2, 0.8),
      bottomRight: const Offset(0.8, 0.8)
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Select the Bon"),),
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const Center(child: Text("Loading image...")),
            Image.file(
              File(currentImageFile.path),
              fit: BoxFit.contain,
              key: imageKey
            ),
            FutureBuilder(
              future: ImageUtils.createImageFromFile(widget.imgFile),
              builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final keyContext = imageKey.currentContext;

                  if (keyContext == null) {
                    return Container();
                  }

                  final box = keyContext.findRenderObject() as RenderBox;
                  ui.Image img = snapshot.data!;
                  return CroppingRectangle(
                    imgRenderSize: Size(box.size.width, box.size.height),
                    imgTrueSize: Size(img.width.toDouble(), img.height.toDouble()),
                    detectedEdges: cropPath,
                  );
                }

                return const CircularProgressIndicator();
              }
            ),
          ],
        )),
      floatingActionButton: ActionButton(
        icon: Icons.crop,
        onPressed: () async {
          ui.Image croppedImg = await ImageUtils.cropImageFromFile(widget.imgFile, cropPath);
          Navigator.push(context, MaterialPageRoute(builder: (_) => ImageScreen(image: croppedImg)));
        },
      ),
    );
  }
  
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    super.dispose();
  }

}
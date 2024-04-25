import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const Text("Loading Image..."),
            Image.file(
              File(widget.imgFile),
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
                  );
                }

                return const CircularProgressIndicator();
              }
            ),
          ],
        )
      ),
      floatingActionButton: ActionButton(
        icon: Icons.crop,
        onPressed: () async {
          //ui.Image croppedImg = ImageUtils.cropImageFromFile(filePath, cropPath, scalingFactor)
        },
      ),
    );
  }

}
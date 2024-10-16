import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/infrastructure/edge_detection/edge_detection_result.dart';
import 'package:split_the_bill/infrastructure/image_processing/image_cropping.dart';
import 'package:split_the_bill/infrastructure/image_processing/image_utils.dart';
import 'package:split_the_bill/presentation/bills/new_bill/items_check_dialog.dart';
import 'package:split_the_bill/presentation/camera/image_cropping/crop_rectangle.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/presentation/shared/components/snackbar.dart';

import '../../bills/new_bill/controllers.dart';

class ImageCropScreen extends ConsumerStatefulWidget {
  const ImageCropScreen({
    super.key,
    required this.imgFile,
    required this.billId,
  });

  final String imgFile;
  final String billId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ImageCropScreenState();
  }
}

class _ImageCropScreenState extends ConsumerState<ImageCropScreen> {
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
      bottomRight: const Offset(0.8, 0.8));

  @override
  Widget build(BuildContext context) {
    /// Show the items check dialog when the bill recognition starts
    ref.listen(billRecognitionProvider, (prev, next) {
      if (!prev!.isLoading) {
        showItemsCheckDialog(context, widget.billId);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Crop Image"),
      ),
      body: Center(
          child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          const Center(child: Text("Loading image...")),
          Image.file(File(currentImageFile.path),
              fit: BoxFit.contain, key: imageKey),
          FutureBuilder(
              future: ImageUtils.createImageFromFile(widget.imgFile),
              builder:
                  (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final keyContext = imageKey.currentContext;

                  if (keyContext == null) {
                    return Container();
                  }

                  final box = keyContext.findRenderObject() as RenderBox;
                  ui.Image img = snapshot.data!;
                  return CroppingRectangle(
                    imgRenderSize: Size(box.size.width, box.size.height),
                    imgTrueSize:
                        Size(img.width.toDouble(), img.height.toDouble()),
                    detectedEdges: cropPath,
                    updateSelectionCallback: _updateCropSelection,
                  );
                }

                return const SizedBox();
              }),
        ],
      )),
      floatingActionButton: ActionButton(
        icon: Icons.check,
        onPressed: () async {
          try {
            Uint8List croppedBytes =
                await ImageCropping.perspectiveImageCropping(
              widget.imgFile,
              cropPath,
            );

            await ref
                .read(billRecognitionProvider.notifier)
                .runBillRecognition(croppedBytes);
          } catch (e) {
            if (context.mounted) {
              showErrorSnackBar(context, e.toString());
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateCropSelection(DetectedRectangle currentSelection) {
    cropPath = currentSelection;
  }
}

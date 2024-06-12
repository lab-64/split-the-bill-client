
import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:split_the_bill/infrastructure/edge_detection/edge_detection_result.dart';
import 'package:split_the_bill/presentation/camera/image_cropping/crop_painter.dart';
import 'package:split_the_bill/presentation/camera/image_cropping/crop_pivot.dart';

class CroppingRectangle extends StatefulWidget {
  CroppingRectangle({
    required this.imgRenderSize,
    required this.imgTrueSize,
    required this.detectedEdges,
    required this.updateSelectionCallback
  });

  final Size imgRenderSize;
  final Size imgTrueSize;
  final Function updateSelectionCallback;
  final DetectedRectangle detectedEdges;

  @override
  State<StatefulWidget> createState() {
    return _CroppingRectangleState();
  }

}

class _CroppingRectangleState extends State<CroppingRectangle> {
  late List<Offset> pivotPositions;
  double pivotSize = 30;

  late double imgRenderWidth;
  late double imgRenderHeight;
  late double top;
  late double left;
  late DetectedRectangle detectedEdges;

  @override
  void initState() {
    left = 0;
    top = 0;

    double scalingFactor = min(widget.imgRenderSize.width / widget.imgTrueSize.width,
      widget.imgRenderSize.height / widget.imgTrueSize.height);
    dev.log("Scaling Factor: ${scalingFactor}");

    imgRenderWidth = widget.imgTrueSize.width * scalingFactor;
    left = ((widget.imgRenderSize.width - imgRenderWidth) / 2);
    imgRenderHeight = widget.imgTrueSize.height * scalingFactor;
    top = ((widget.imgRenderSize.height - imgRenderHeight) / 2);
    dev.log("imgRenderWidth: $imgRenderWidth, imgRenderHeight: $imgRenderHeight");
    dev.log("left: $left, top: $top");


    detectedEdges = DetectedRectangle(
        topLeft: const Offset(0.2, 0.2),
        topRight: const Offset(0.8, 0.2),
        bottomLeft: const Offset(0.2, 0.8),
        bottomRight: const Offset(0.8, 0.8)
    );


    pivotPositions = [
      Offset(
          left + detectedEdges.topLeft.dx * imgRenderWidth,
          top + detectedEdges.topLeft.dy * imgRenderHeight
      ),
      Offset(
        left + detectedEdges.topRight.dx * imgRenderWidth,
        top + detectedEdges.topRight.dy * imgRenderHeight,
      ),
      Offset(
          left + detectedEdges.bottomRight.dx * imgRenderWidth,
          top + detectedEdges.bottomRight.dy * imgRenderHeight
      ),
      Offset(
          left + detectedEdges.bottomLeft.dx * imgRenderWidth,
          top + detectedEdges.bottomLeft.dy * imgRenderHeight
      ),
      Offset(
          left + detectedEdges.topLeft.dx * imgRenderWidth,
          top + detectedEdges.topLeft.dy * imgRenderHeight
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          alignment: Alignment.topRight,
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: CroppingPainter(
                pivots: pivotPositions,
                color: Colors.blue.shade400,
              ),
            ),
            _drawDraggablePivots(),
          ],
    );
  }

  Widget _drawDraggablePivots() {
    pivotPositions = [
      Offset(
          left + detectedEdges.topLeft.dx * imgRenderWidth,
          top + detectedEdges.topLeft.dy * imgRenderHeight
      ),
      Offset(
        left + detectedEdges.topRight.dx * imgRenderWidth,
        top + detectedEdges.topRight.dy * imgRenderHeight,
      ),
      Offset(
          left + detectedEdges.bottomRight.dx * imgRenderWidth,
          top + detectedEdges.bottomRight.dy * imgRenderHeight
      ),
      Offset(
          left + detectedEdges.bottomLeft.dx * imgRenderWidth,
          top + detectedEdges.bottomLeft.dy * imgRenderHeight
      ),
      Offset(
          left + detectedEdges.topLeft.dx * imgRenderWidth,
          top + detectedEdges.topLeft.dy * imgRenderHeight
      ),
    ];

    _updateCropSelection();

    return SizedBox(
        width: widget.imgRenderSize.width,
        height: widget.imgRenderSize.height,
        child: Stack(
        children: [
          Positioned(
            left: pivotPositions[0].dx - (pivotSize / 2),
            top: pivotPositions[0].dy - (pivotSize / 2),
            child: CroppingPivot(
              size: pivotSize,
              onDragCallback: (position) {
                setState(() {
                  Offset newPos = _applyPositionScaling(position);
                  detectedEdges.topLeft = _clampPos(detectedEdges.topLeft + newPos);
                });
              },
            ),
          ),
          Positioned(
            left: pivotPositions[1].dx - (pivotSize / 2),
            top: pivotPositions[1].dy - (pivotSize / 2),
            child: CroppingPivot(
              size: pivotSize,
              onDragCallback: (position) {
                setState(() {
                  Offset newPos = _applyPositionScaling(position);
                  detectedEdges.topRight = _clampPos(detectedEdges.topRight + newPos);
                });
              },
            ),
          ),
          Positioned(
            left: pivotPositions[2].dx - (pivotSize / 2),
            top: pivotPositions[2].dy - (pivotSize / 2),
            child: CroppingPivot(
              size: pivotSize,
              onDragCallback: (position) {
                setState(() {
                  Offset newPos = _applyPositionScaling(position);
                  detectedEdges.bottomRight = _clampPos(detectedEdges.bottomRight + newPos);
                });
              },
            ),
          ),
          Positioned(
            left: pivotPositions[3].dx - (pivotSize / 2),
            top: pivotPositions[3].dy - (pivotSize / 2),
            child: CroppingPivot(
              size: pivotSize,
              onDragCallback: (position) {
                setState(() {
                  Offset newPos = _applyPositionScaling(position);
                  detectedEdges.bottomLeft = _clampPos(detectedEdges.bottomLeft + newPos);
                });
              },
            ),
          ),
      ],

    ));
  }

  Offset _applyPositionScaling(Offset pos) {
    return Offset(
      pos.dx / imgRenderWidth,
      pos.dy / imgRenderHeight
    );
  }

  Offset _clampPos(Offset pos) {
    double x = pos.dx * imgRenderWidth;
    double y = pos.dy * imgRenderHeight;

    return Offset(
      x.clamp(0.0, imgRenderWidth) / imgRenderWidth,
      y.clamp(0.0, imgRenderHeight) / imgRenderHeight
    );
  }

  void _updateCropSelection() {
    widget.updateSelectionCallback(detectedEdges);
  }


}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:split_the_bill/infrastructure/edge_detection/edge_detection_result.dart';
import 'package:split_the_bill/presentation/camera/image_cropping/crop_painter.dart';
import 'package:split_the_bill/presentation/camera/image_cropping/crop_pivot.dart';

class CroppingRectangle extends StatefulWidget {
  const CroppingRectangle({
    required this.imgRenderSize,
    required this.imgTrueSize,
    this.detectedEdges,
  });

  final Size imgRenderSize;
  final Size imgTrueSize;
  final DetectedRectangle? detectedEdges;

  @override
  State<StatefulWidget> createState() {
    return _CroppingRectangleState();
  }

}

class _CroppingRectangleState extends State<CroppingRectangle> {
  late List<Offset> pivotPositions;
  double pivotSize = 15;

  late double imgRenderWidth;
  late double imgRenderHeight;
  late double top;
  late double left;
  late DetectedRectangle detectedEdges;

  @override
  void initState() {
    left = 0;
    top = 0;

    if (widget.detectedEdges == null) {
      detectedEdges = DetectedRectangle(
          topLeft: const Offset(150, 150),
          topRight: Offset(widget.imgRenderSize.width - 150, 150),
          bottomLeft: Offset(150, widget.imgRenderSize.height- 150),
          bottommRight: Offset(widget.imgRenderSize.width - 150, widget.imgRenderSize.height - 150)
      );
    }
    else {
      detectedEdges = widget.detectedEdges!;
    }

    pivotPositions = [
      Offset(
          left + detectedEdges.topLeft.dx,
          top + detectedEdges.topLeft.dy
      ),
      Offset(
        left + detectedEdges.topRight.dx,
        top + detectedEdges.topRight.dy,
      ),
      Offset(
          left + detectedEdges.bottommRight.dx,
          top + detectedEdges.bottommRight.dy
      ),
      Offset(
          left + detectedEdges.bottomLeft.dx,
          top + detectedEdges.bottomLeft.dy
      ),
      Offset(
          left + detectedEdges.topLeft.dx,
          top + detectedEdges.topLeft.dy
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _drawDraggablePivots(),
        CustomPaint(
          painter: CroppingPainter(
            pivots: pivotPositions,
            color: Colors.blue.shade400,
          ),
        ),
      ],
    );
  }

  Widget _drawDraggablePivots() {
    log("${pivotPositions[0]}");

    return Container(
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
                log("${position}");
                setState(() {
                  pivotPositions[0] += position;
                  pivotPositions[4] += position;
                });
              },
              onFinishedDragCallback: (_) {
                setState(() {});
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
                  pivotPositions[1] += position;
                });
              },
              onFinishedDragCallback: (_) {
                setState(() {});
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
                  pivotPositions[2] += position;
                });
              },
              onFinishedDragCallback: (_) {
                setState(() {});
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
                  pivotPositions[3] += position;
                });
              },
              onFinishedDragCallback: (_) {
                setState(() {});
              },
            ),
          ),
      ],
      )
    );
  }



}
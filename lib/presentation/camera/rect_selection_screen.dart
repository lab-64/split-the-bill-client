import 'package:flutter/cupertino.dart';
import 'package:split_the_bill/presentation/camera/selector_pivot.dart';
import 'package:split_the_bill/presentation/ffi/edge_detection.dart';
import 'package:image/image.dart' as imgLib;

class RectSelectionScreen extends StatefulWidget {
  RectSelectionScreen({ this.detectedRect, required this.img, required this.color});

  final DetectedRect? detectedRect;
  final imgLib.Image img;

  final Color color;

  @override
  State<StatefulWidget> createState() {
    return RectSelectionScreenState();
  }
}

class RectSelectionScreenState extends State<RectSelectionScreen> {
  late Offset topRight;
  late Offset topLeft;
  late Offset bottomLeft;
  late Offset bottomRight;

  static const double pivotBaseSize = 15.0;

  late double pivotSize;
  Color rectColor = ColorFloat64.rgb(0.0, 1.0, 0.0);

  @override
  void initState() {
    pivotSize = pivotBaseSize;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Text("Loading image..."),
        Image(image: Image.memory(widget.img.getBytes()).image),
        RectSelectionPivot(
            type: PivotType.topLeft,
            size: pivotSize,
            panStart: _panStart,
            panUpdate: _panUpdate,
            panEnd: _panEnd,
        ),
        RectSelectionPivot(
          type: PivotType.topRight,
          size: pivotSize,
          panStart: _panStart,
          panUpdate: _panUpdate,
          panEnd: _panEnd,
        ),
        RectSelectionPivot(
          type: PivotType.bottomRight,
          size: pivotSize,
          panStart: _panStart,
          panUpdate: _panUpdate,
          panEnd: _panEnd,
        ),
        RectSelectionPivot(
          type: PivotType.bottomLeft,
          size: pivotSize,
          panStart: _panStart,
          panUpdate: _panUpdate,
          panEnd: _panEnd,
        ),
      ],
    );
  }

  void _panStart(PivotType type, Offset pos) {
    setState(() {
      pivotSize = pivotBaseSize * 1.5;

      switch(type) {
        case PivotType.topLeft:
          topLeft = pos;
          break;
        case PivotType.topRight:
          topRight = pos;
          break;
        case PivotType.bottomLeft:
          bottomLeft = pos;
          break;
        case PivotType.bottomRight:
          bottomRight = pos;
          break;
      }
    });
  }

  void _panUpdate(PivotType type, Offset pos) {
    setState(() {
      switch(type) {
        case PivotType.topLeft:
          topLeft = pos;
          break;
        case PivotType.topRight:
          topRight = pos;
          break;
        case PivotType.bottomLeft:
          bottomLeft = pos;
          break;
        case PivotType.bottomRight:
          bottomRight = pos;
          break;
      }
    });
  }

  void _panEnd(PivotType type) {
    setState(() {
      pivotSize = pivotBaseSize;
    });
  }

}
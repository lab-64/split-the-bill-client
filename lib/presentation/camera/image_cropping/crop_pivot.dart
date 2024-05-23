
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CroppingPivot extends StatefulWidget {
  const CroppingPivot({
    super.key,
    required this.size,
    required this.onDragCallback,
  });

  final double size;
  final Function onDragCallback;

  @override
  State<StatefulWidget> createState() {
    return _CroppingPivotState();
  }

}

class _CroppingPivotState extends State<CroppingPivot> {
  bool activeDrag = false;
  late double currentSize;

  @override
  void initState() {
    currentSize = widget.size;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // Gesture Detector to detect drag (pan) input and initiate callback Functions to update pos
    return GestureDetector(
      onPanStart: _dragStart,
      onPanUpdate: _dragging,
      onPanEnd: _dragEnd,
      onPanCancel: _dragCancel,
      child: Container(
        width: currentSize,
        height: currentSize,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(currentSize / 2)
        ),
      )
    );
  }

  void _dragStart(DragStartDetails details) {
    setState(() {
      activeDrag = true;
      currentSize = 2 * widget.size;
    });
    widget.onDragCallback(details.localPosition - Offset(currentSize / 2, currentSize / 2));
  }

  void _dragging(DragUpdateDetails details){
    if (activeDrag) {
      widget.onDragCallback(details.delta);
    }
  }

  void _dragCancel() {
    setState(() {
      activeDrag = false;
      currentSize = widget.size;
    });

  }

  void _dragEnd(DragEndDetails details) {
    _dragCancel();
  }

}
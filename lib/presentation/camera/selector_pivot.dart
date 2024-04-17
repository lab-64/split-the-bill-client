import 'package:flutter/widgets.dart';

enum PivotType {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class RectSelectionPivot extends StatelessWidget{

  RectSelectionPivot({
    this.pos,
    required this.type,
    required this.size,
    required this.panStart,
    required this.panUpdate,
    required this.panEnd,
  });
  final PivotType type;

  final Offset? pos;
  final double size;
  final Function panStart;
  final Function panUpdate;
  final Function panEnd;


  @override
  build(BuildContext context) {
    return Positioned(
        child: GestureDetector(
          onPanStart: (state) => panStart(type, state.globalPosition),
          onPanUpdate: (state) => panUpdate(type, state.globalPosition),
          onPanEnd: (_) => panEnd(type),
        )
    );
  }
}
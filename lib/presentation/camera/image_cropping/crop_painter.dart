
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CroppingPainter extends CustomPainter {
  const CroppingPainter({
    required this.pivots,
    required this.color,
  });

  final List<Offset> pivots;

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
        ..color = color.withOpacity(0.7)
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;
    
    canvas.drawPoints(PointMode.polygon, pivots, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}

import 'dart:ui';

class DetectedRectangle {
  const DetectedRectangle({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottommRight,
  });

  final Offset topLeft;
  final Offset topRight;
  final Offset bottomLeft;
  final Offset bottommRight;

}
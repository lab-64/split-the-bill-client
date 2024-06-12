
import 'dart:ffi';
import 'dart:ui';

class DetectedRectangle {
  DetectedRectangle({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
  });

  Offset topLeft;
  Offset topRight;
  Offset bottomLeft;
  Offset bottomRight;
}

final class NativeDetectedRectangle extends Struct {
  @Array(2)
  external Array<Double> topLeft;
  @Array(2)
  external Array<Double> topRight;
  @Array(2)
  external Array<Double> bottomRight;
  @Array(2)
  external Array<Double> bottomLeft;
}
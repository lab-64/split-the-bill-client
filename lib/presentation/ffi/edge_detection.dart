import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:ffi/ffi.dart' as ffi;

final DynamicLibrary nativeContourDetectionLib = Platform.isAndroid
    ? DynamicLibrary.open("libopencv_detection.so")
    : DynamicLibrary.process();


final class NativeDetectedRect extends Struct {
  @Array(2)
  external Array<Double> topLeft;
  @Array(2)
  external Array<Double> topRight;
  @Array(2)
  external Array<Double> bottomLeft;
  @Array(2)
  external Array<Double> bottomRight;
}
class DetectedRect {
  DetectedRect({
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

typedef DetectRectFunctionNative = Pointer<NativeDetectedRect> Function(Pointer<Uint8>, Uint32);
typedef DetectRectFunction = Pointer<NativeDetectedRect> Function(Pointer<Uint8>, int);
// final detectSquares = nativeContourDetectionLib.lookupFunction<DetectRectFunctionNative, DetectRectFunction>("detect_contour");

class RectDetection {

  static DetectedRect detectRect(Uint8List imgBytes) {
    final detectSquares = nativeContourDetectionLib.lookupFunction<DetectRectFunctionNative, DetectRectFunction>("detect_contour");
    Pointer<Uint8> inputBuffer = ffi.malloc.allocate(imgBytes.length);
    inputBuffer.asTypedList(imgBytes.length).setAll(0, imgBytes);
    NativeDetectedRect rect = detectSquares(inputBuffer, imgBytes.length).ref;

    return DetectedRect(
        topLeft: Offset(rect.topLeft[0], rect.topLeft[1]),
        topRight: Offset(rect.topRight[0], rect.topRight[1]),
        bottomLeft: Offset(rect.bottomLeft[0], rect.bottomLeft[1]),
        bottomRight: Offset(rect.bottomRight[0], rect.bottomRight[1]),
    );
  }
}

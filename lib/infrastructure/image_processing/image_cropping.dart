
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:ffi/ffi.dart' as ffi;

import 'package:split_the_bill/infrastructure/edge_detection/edge_detection_result.dart';

final DynamicLibrary nativeImageCropping = Platform.isAndroid
    ? DynamicLibrary.open("libopencv_cropping.so")
    : DynamicLibrary.process();

typedef PerspectiveCroppingFunctionNative = Uint32 Function(Pointer<ffi.Utf8>, Pointer<NativeDetectedRectangle>, Pointer<Pointer<Uint8>>);
typedef PerspectiveCroppingFunction = int Function(Pointer<ffi.Utf8>, Pointer<NativeDetectedRectangle>, Pointer<Pointer<Uint8>>);

class ImageCropping {


  static Future<Uint8List>  perspectiveImageCropping(String imgPath, DetectedRectangle cropPath) async {
    final perspectiveCropping = nativeImageCropping.lookupFunction<PerspectiveCroppingFunctionNative, PerspectiveCroppingFunction>("perspectiveTransform");

    Pointer<Pointer<Uint8>> outputBuffer = ffi.malloc.allocate(sizeOf<Pointer<Uint8>>());
    final imgPathNative = imgPath.toNativeUtf8();

    final Pointer<NativeDetectedRectangle> cropPathPtr = ffi.malloc.allocate(sizeOf<NativeDetectedRectangle>());
    NativeDetectedRectangle nativeCropPath = cropPathPtr.ref;
    nativeCropPath.topLeft[0] = cropPath.topLeft.dx;
    nativeCropPath.topLeft[1] = cropPath.topLeft.dy;
    nativeCropPath.topRight[0] = cropPath.topRight.dx;
    nativeCropPath.topRight[1] = cropPath.topRight.dy;
    nativeCropPath.bottomRight[0] = cropPath.bottomRight.dx;
    nativeCropPath.bottomRight[1] = cropPath.bottomRight.dy;
    nativeCropPath.bottomLeft[0] = cropPath.bottomLeft.dx;
    nativeCropPath.bottomLeft[1] = cropPath.bottomLeft.dy;

    int outputSize = perspectiveCropping(imgPathNative, cropPathPtr, outputBuffer);
    if (outputSize == 0) {
      log("decoded image was null");
      return Uint8List(0);
    }
    Uint8List projectedBytes = outputBuffer.value.asTypedList(outputSize);

    ffi.malloc.free(cropPathPtr);
    ffi.malloc.free(imgPathNative);
    ffi.malloc.free(outputBuffer.value);
    ffi.malloc.free(outputBuffer);
    return projectedBytes;
  }
}
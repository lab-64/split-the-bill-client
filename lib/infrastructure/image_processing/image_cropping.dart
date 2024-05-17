
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:ffi/ffi.dart' as ffi;

import 'package:split_the_bill/infrastructure/edge_detection/edge_detection_result.dart';

final DynamicLibrary nativeImageCropping = Platform.isAndroid
    ? DynamicLibrary.open("libopencv_cropping.so")
    : DynamicLibrary.process();

typedef PerspectiveCroppingFunctionNative = Uint32 Function(Pointer<Uint8>, NativeDetectedRectangle, Pointer<Pointer<Uint8>>, Uint32);
typedef PerspectiveCroppingFunction = int Function(Pointer<Uint8>, NativeDetectedRectangle, Pointer<Pointer<Uint8>>, int);

class ImageCropping {


  static Future<ui.Image>  perspectiveImageCropping(ui.Image inputImg, DetectedRectangle cropPath) async {
    final perspectiveCropping = nativeImageCropping.lookupFunction<PerspectiveCroppingFunctionNative, PerspectiveCroppingFunction>("perspectiveTransform");
    Uint8List inputBytes = (await inputImg.toByteData())!.buffer.asUint8List();
    Pointer<Uint8> inputBuffer = ffi.malloc.allocate(inputBytes.length);
    inputBuffer.asTypedList(inputBytes.length).setAll(0, inputBytes);
    Pointer<Pointer<Uint8>> outputBuffer = ffi.malloc.allocate(sizeOf<Pointer<Uint8>>());

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


    int outputSize = perspectiveCropping(inputBuffer, nativeCropPath, outputBuffer, inputBytes.length);
    Uint8List projectedBytes = outputBuffer.value.asTypedList(outputSize);
    ui.Codec codec = await ui.instantiateImageCodec(projectedBytes);
    ui.Image projectedImage = (await codec.getNextFrame()).image;
    ffi.malloc.free(inputBuffer);
    ffi.malloc.free(outputBuffer.value);
    ffi.malloc.free(outputBuffer);
    return projectedImage;
  }
}
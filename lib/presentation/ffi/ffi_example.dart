import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/camera/bill_camera.dart';

final DynamicLibrary nativeMonteCarloPiLib = Platform.isAndroid
    ? DynamicLibrary.open("libmonte_carlo_pi.so")
    : DynamicLibrary.process();

final DynamicLibrary nativeContourDetectionLib = Platform.isAndroid
    ? DynamicLibrary.open("libopencv_detection.so")
    : DynamicLibrary.process();

final monteCarloPi = nativeMonteCarloPiLib.lookupFunction<Double Function(Int32), double Function(int)>("monte_carlo_pi");
// final contourDetection = nativeContourDetectionLib.lookupFunction<Uint64 Function(Pointer<Uint8>, Pointer<Pointer<Uint8>>, Int32), int Function(Pointer<Uint8>, Pointer<Pointer<Uint8>>, int)>("detect_contour");


final class NativeDetectedSquare extends Struct {
  @Array(2)
  external Array<Double> topLeft;
  @Array(2)
  external Array<Double> topRight;
  @Array(2)
  external Array<Double> bottomLeft;
  @Array(2)
  external Array<Double> bottomRight;
}
class DetectedSquare {
  DetectedSquare({
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

typedef DetectSquaresFunctionNative = Pointer<NativeDetectedSquare> Function(Pointer<Uint8>, Pointer<Pointer<Uint8>>, Int32);
typedef DetectSquaresFunction = Pointer<NativeDetectedSquare> Function(Pointer<Uint8>, Pointer<Pointer<Uint8>>, int);
final detectSquares = nativeContourDetectionLib.lookupFunction<DetectSquaresFunctionNative, DetectSquaresFunction>("detect_contours");


//final squareDetection = nativeContourDetectionLib.lookupFunction<Pointer<NativeDetectedSquare> Function(Pointer<Uint8>, Pointer<Pointer<Uint8>>, Int32), Pointer<DetectedSquare> Function(Pointer<Uint8>, Pointer<Pointer<Uint8>>, int)>("detect_contour");

class FFIExample extends StatefulWidget{
  FFIExample({ super.key, this.cameras});

  late final List<CameraDescription>? cameras;

  @override
  State<FFIExample> createState() => _FFIExampleState();
}

class _FFIExampleState extends State<FFIExample> {


  double _pi = 0.0;
  final sampleController = TextEditingController();

  // MemoryImage? img;
  Uint8List? rawImage;
  // ui.Codec? imgCodec;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    sampleController.dispose();
    super.dispose();
  }


  Future<ui.Image> createImage(ui.ImmutableBuffer buffer) async {
    ui.Codec codec = await ui.instantiateImageCodecFromBuffer(buffer);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }

  late DetectedSquare square;

  var appBar = AppBar(title: const Text("FFI Example"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: "Enter sample size",
              ),
              controller: sampleController,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            Text("Pi is approximately $_pi", style: const TextStyle(fontSize: 18, color: Colors.black),),
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

                    ui.ImmutableBuffer buffer = await ui.ImmutableBuffer.fromFilePath(result!.files.first.path!);
                    // ui.Image newImage = await createImage(buffer);
                    // ui.Codec newCodec = await ui.instantiateImageCodecFromBuffer(buffer);
                    MemoryImage image = MemoryImage(await File(result.files.first.path!).readAsBytes());
                    setState(() {
                      rawImage = image.bytes;
                    });
                  },
                  child: const Text("Select Image"),
                ),
                // TextButton(
                //   onPressed: () async {
                //     var img = rawImage;
                //     if (img != null) {
                //       // ByteData? byteArray = await img.toByteData(format: ui.ImageByteFormat.rawUnmodified);
                //       // Uint8List byteList = byteArray!.buffer.asUint8List();
                //       Uint8List byteList = img;
                //       Pointer<Uint8> inputBuffer = ffi.malloc.allocate(byteList.length);
                //       inputBuffer.asTypedList(byteList.length).setAll(0, byteList);
                //       Pointer<Pointer<Uint8>> outputBuffer = ffi.malloc.allocate(sizeOf<Pointer>());
                //
                //       // int outputSize = contourDetection(inputBuffer, outputBuffer, byteList.length);
                //       // //ui.ImmutableBuffer imgBuffer = await ui.ImmutableBuffer.fromUint8List(buffer.asTypedList(byteList.length));
                //       // // img = await createImage(imgBuffer);
                //       // // ui.ImageDescriptor imageDescriptor = ui.ImageDescriptor.raw(imgBuffer, width: img.width, height: img.height, pixelFormat: ui.PixelFormat.rgba8888);
                //       // //assert(listEquals(byteList, buffer.asTypedList(byteList.length)) == true);
                //       // /*log("${byteList[4]}");
                //       // log("${buffer.asTypedList(5).last}");*/
                //       // Pointer<Uint8> ptr = outputBuffer.elementAt(0).value;
                //       // setState(() {
                //       //
                //       //   rawImage = Uint8List.fromList(ptr.asTypedList(outputSize));
                //       // });
                //       NativeDetectedSquare nativeSquare = detectSquares(inputBuffer, outputBuffer, byteList.length).ref;
                //       setState(() {
                //         square.topLeft = Offset(nativeSquare.topLeft[0], nativeSquare.topLeft[1]);
                //         square.topRight = Offset(nativeSquare.topRight[0], nativeSquare.topRight[1]);
                //         square.topLeft = Offset(nativeSquare.bottomLeft[0], nativeSquare.bottomLeft[1]);
                //         square.topLeft = Offset(nativeSquare.bottomRight[0], nativeSquare.bottomRight[1]);
                //
                //       });
                //
                //       ffi.malloc.free(inputBuffer);
                //       ffi.malloc.free(outputBuffer.value);
                //       ffi.malloc.free(outputBuffer);
                //     }
                //   },
                //   child: Text("Detect Edges ${nativeContourDetectionLib.providesSymbol("detect_contour")}"),
                // ),
                TextButton(
                  onPressed: () async {
                    await availableCameras().then((value) => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
                  },
                  child: const Text("Camera")
                )
              ]
            ),
            // InteractiveViewer(
            //   minScale: 0.1,
            //   maxScale: 1.8,
            //   child: img ?? const Text("No Image loaded"),
            // )
            Expanded(child: rawImage != null ? Image.memory(rawImage!, fit: BoxFit.contain) :  const Text("No Image loaded"),
            // ),
            // Expanded(
            //   child: FutureBuilder<void>(
            //       future: _initializeControllerFuture,
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.done) {
            //           return CameraPreview(_controller);
            //         }
            //         else {
            //           return const Center(child: CircularProgressIndicator());
            //         }
            //       }
            //   )
            )
          ]
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int n = int.parse(sampleController.text);
          setState(() {
            _pi = monteCarloPi(n);
          });
        },
      ),
    );
  }
}
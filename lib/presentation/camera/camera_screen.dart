import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:split_the_bill/presentation/shared/components/action_button.dart';
import 'package:split_the_bill/router/routes.dart';

class CameraScreen extends StatefulWidget {

  const CameraScreen({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _CameraScreenState();
  }

}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();

    _initCameras();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            }
            else {
              return const Center(child: CircularProgressIndicator());
            }
          }
      ),
      floatingActionButton: ActionButton(
        icon: Icons.photo_camera,
        onPressed: () async {
          XFile imgFile = await _controller.takePicture();
          return ImageCropRoute(imgFile.path).push(context);
        },
      ),
    );
  }

  void _initCameras() async {
    cameras = await availableCameras();

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    setState(() {
      _initializeControllerFuture = _controller.initialize();
    });
  }

}
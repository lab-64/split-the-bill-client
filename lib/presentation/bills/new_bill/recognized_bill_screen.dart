import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RecognizedBillScreen extends StatelessWidget {
  const RecognizedBillScreen({super.key /*, required this.image}*/});

  //final XFile? image;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Recognized Bill Screen"),
      ),
    );
  }
}

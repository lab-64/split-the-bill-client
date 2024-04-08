import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/shared/util/util.dart';

class EditImageModal extends StatelessWidget {
  const EditImageModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Take a photo'),
          onTap: () => showNotImplementedSnackBar(context),
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('Select image'),
          onTap: () => showNotImplementedSnackBar(context),
        ),
      ],
    );
  }
}

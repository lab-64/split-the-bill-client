import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditImageModal extends StatelessWidget {
  const EditImageModal({
    super.key,
    required this.getImage,
  });
  final Function(ImageSource) getImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Take a photo'),
          onTap: () => getImage(ImageSource.camera)
              .then((_) => GoRouter.of(context).pop()),
        ),
        ListTile(
            leading: const Icon(Icons.image),
            title: const Text('Select image'),
            onTap: () => getImage(ImageSource.gallery)
                .then((_) => GoRouter.of(context).pop())),
      ],
    );
  }
}

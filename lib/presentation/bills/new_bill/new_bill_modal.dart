import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/router/routes.dart';

class NewBillModal extends StatelessWidget {
  const NewBillModal({
    super.key,
    required this.getImage,
    required this.group,
    required this.onImageSelection,
  });
  final Function(ImageSource) getImage;
  final Group group;
  final VoidCallback onImageSelection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Take a photo'),
          onTap: () => getImage(ImageSource.camera).then(
            (_) => onImageSelection(),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('Select image'),
          onTap: () => getImage(ImageSource.gallery).then(
            (_) => onImageSelection(),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.edit),
          title: const Text('Add bill manually'),
          onTap: () => onImageSelection,
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';

class ProfileImage extends ConsumerWidget {
  const ProfileImage({
    super.key,
    required this.user,
    this.size = Sizes.p24,
    this.onPressed,
    this.showOverlayIcon = false,
    this.previewImage,
  });

  final User user;
  final double size;
  final VoidCallback? onPressed;
  final bool showOverlayIcon;
  final XFile? previewImage;

  ImageProvider<Object> getProfileImage(
    XFile? previewImage,
    String imagePath,
    Map<String, String> headers,
  ) {
    if (previewImage != null) {
      return FileImage(File(previewImage.path));
    } else if (imagePath.isNotEmpty) {
      return NetworkImage(
        imagePath,
        headers: headers,
      );
    } else {
      return const AssetImage('assets/avatar.jpg');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authUser = ref.watch(authStateProvider);

    final String imagePath = user.profileImgPath;
    final ImageProvider<Object> image = getProfileImage(
      previewImage,
      imagePath,
      {
        'cookie': authUser.requireValue.sessionCookie,
      },
    );

    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          CircleAvatar(
            radius: size,
            child: CircleAvatar(
              radius: size - 1,
              backgroundImage: image,
            ),
          ),
          if (showOverlayIcon)
            Positioned.fill(
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: size * 0.6,
              ),
            ),
        ],
      ),
    );
  }
}

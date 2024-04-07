import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/infrastructure/session.dart';

class ProfileImage extends ConsumerWidget {
  const ProfileImage({
    super.key,
    required this.user,
    this.size = Sizes.p24,
    this.onPressed,
    this.showOverlayIcon = false,
  });

  final User user;
  final double size;
  final VoidCallback? onPressed;
  final bool showOverlayIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final String imagePath = user.getImagePath();

    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          CircleAvatar(
            radius: size,
            child: CircleAvatar(
              radius: size - 1,
              backgroundImage: imagePath.isNotEmpty
                  ? NetworkImage(
                      imagePath,
                      headers: Map<String, String>.from(session.headers),
                    ) as ImageProvider<Object>
                  : const AssetImage('assets/avatar.jpg'),
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

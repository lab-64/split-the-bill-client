import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/infrastructure/session.dart';

class ProfileImage extends ConsumerWidget {
  const ProfileImage({super.key, required this.user, this.size = Sizes.p24});
  final User user;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final String imagePath = user.getImagePath();

    return CircleAvatar(
      radius: size,
      backgroundImage: imagePath.isNotEmpty
          ? NetworkImage(
              imagePath,
              headers: Map<String, String>.from(session.headers),
            ) as ImageProvider<Object>
          : const AssetImage('assets/avatar.jpg'),
    );
  }
}

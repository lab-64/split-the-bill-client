import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/presentation/shared/navigation/controllers.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';
import 'package:split_the_bill/presentation/shared/util/util.dart';
import 'package:split_the_bill/routes.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).requireValue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildUserInfo(context, ref, user),
        _buildActionIcons(context),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context, WidgetRef ref, User user) {
    return Row(
      children: [
        ProfileImage(
            user: user, onPressed: () => _onProfileImagePressed(context, ref)),
        gapW16,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome back!'),
            Text(
              user.getDisplayName(),
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionIcons(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications_outlined),
      onPressed: () => showNotImplementedSnackBar(context),
    );
  }

  void _onProfileImagePressed(BuildContext context, WidgetRef ref) {
    ref
        .read(navbarControllerProvider.notifier)
        .setIndex(NavbarRoutes.profile.index);
    context.goNamed(
      NavbarRoutes.profile.name,
    );
  }
}

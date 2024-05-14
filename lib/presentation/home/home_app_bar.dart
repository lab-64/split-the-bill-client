import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/home/notifications_dialog.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/ellipse_text.dart';
import 'package:split_the_bill/presentation/shared/components/show_custom_dialog.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';
import 'package:split_the_bill/router/routes.dart';

import '../../domain/bill/states/bills_state.dart';
import '../shared/async_value_widget.dart';
import '../shared/components/custom_dialog.dart';
import '../shared/components/ellipse_text.dart';
import 'notifications_dialog.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).requireValue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildUserInfo(context, ref, user),
        _buildActionIcons(context, ref),
      ],
    );
  }

  Widget _buildUserInfo(BuildContext context, WidgetRef ref, User user) {
    return Row(
      children: [
        ProfileImage(
          user: user,
          onPressed: () => const ProfileRoute().go(context),
        ),
        gapW16,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome back!'),
            EllipseText(
              text: user.getDisplayName(),
              size: Sizes.p64 * 3,
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

  Widget _buildActionIcons(BuildContext context, WidgetRef ref) {
    final bills = ref.watch(billsStateProvider(isUnseen: true));

    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () => showCustomDialog(
            context: context,
            title: 'Notifications',
            content: const NotificationsDialog(),
          ),
        ),
        AsyncValueWidget(
          value: bills,
          data: (bills) {
            if (bills.isEmpty) {
              return const SizedBox();
            }
            return Positioned(
              right: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(Sizes.p8),
                ),
                constraints: const BoxConstraints(
                  minWidth: Sizes.p16,
                  minHeight: Sizes.p16,
                ),
                child: Text(
                  '${bills.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

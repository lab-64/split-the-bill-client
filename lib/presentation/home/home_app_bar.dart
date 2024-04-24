import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/auth/user.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/bill/states/bills_state.dart';
import 'package:split_the_bill/presentation/shared/components/ellipse_text.dart';
import 'package:split_the_bill/presentation/shared/profile/profile_image.dart';
import 'package:split_the_bill/router/routes.dart';

import '../../domain/bill/bill.dart';

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
    Future<List<Bill>> bills =
        ref.read(billsStateProvider.notifier).getNotSeenBillsByUser();
    //TODO probably change to AsyncValueWidget
    //TODO change if other notifications are implemented
    return FutureBuilder(
        future: bills,
        builder: (context, AsyncSnapshot<List<Bill>> snapshot) {
          if (snapshot.hasData) {
            return PopupMenuButton(
                icon: const Icon(Icons.notifications),
                position: PopupMenuPosition.under,
                itemBuilder: (context) => snapshot.data!
                    .map((bill) => PopupMenuItem(
                          child: Text("${bill.name} was added!"),
                          onTap: () =>
                              UnseenBillRoute(billId: bill.id).push(context),
                        ))
                    .toList());
          }
          return const Icon(Icons.notifications_none);
        });
  }
}

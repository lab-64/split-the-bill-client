import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/presentation/shared/primary_button.dart';
import 'package:split_the_bill/routes.dart';

class AddNewGroupButton extends StatelessWidget {
  const AddNewGroupButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: Sizes.p16,
          right: Sizes.p16,
          top: Sizes.p32,
        ),
        child: PrimaryButton(
          onPressed: () => context.pushNamed(Routes.newGroup.name),
          text: 'Add New Group',
        ),
      ),
    );
  }
}

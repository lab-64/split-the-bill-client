import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/domain/tutorial/tutorial_state.dart';
import 'package:split_the_bill/presentation/groups/groups/join_group_dialog.dart';
import 'package:split_the_bill/presentation/shared/components/primary_button.dart';
import 'package:split_the_bill/presentation/shared/components/tutorial_help_button.dart';
import 'package:split_the_bill/presentation/shared/components/tutorial_popup.dart';
import 'package:split_the_bill/presentation/shared/groups/groups_list.dart';
import 'package:split_the_bill/router/routes.dart';

class GroupsScreen extends ConsumerWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();

    final isTutorialSeen =
        ref.watch(tutorialControllerProvider(TutorialScreen.groups));

    if (!isTutorialSeen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showTutorialDialog(
          context: context,
          screen: TutorialScreen.groups,
          onDismiss: () => ref
              .read(tutorialControllerProvider(TutorialScreen.groups).notifier)
              .markAsSeen(),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Groups"),
        actions: [
          if (isTutorialSeen)
            TutorialHelpButton(
              onPressed: () => showTutorialDialog(
                context: context,
                screen: TutorialScreen.groups,
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
        child: Column(
          children: [
            gapH16,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () => showDialog<void>(
                      context: context,
                      builder: (BuildContext context) =>
                          const JoinGroupDialog(),
                    ),
                    icon: Icons.arrow_forward,
                    backgroundColor: Colors.purple.shade300,
                    text: "Join Group",
                  ),
                ),
                gapW8,
                Expanded(
                  child: PrimaryButton(
                    onPressed: () =>
                        const EditGroupRoute(groupId: '0').push(context),
                    icon: Icons.add,
                    backgroundColor: Colors.green.shade300,
                    text: "Add Group",
                  ),
                ),
              ],
            ),
            gapH16,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.refresh(groupsStateProvider.future),
                child: CustomScrollView(
                  slivers: [
                    GroupsList(scrollController: scrollController),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

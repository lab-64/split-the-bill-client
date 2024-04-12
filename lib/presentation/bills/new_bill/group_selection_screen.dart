import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/domain/group/states/groups_state.dart';
import 'package:split_the_bill/presentation/bills/new_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/new_bill/new_bill_modal.dart';
import 'package:split_the_bill/presentation/shared/async_value_widget.dart';
import 'package:split_the_bill/presentation/shared/components/bottom_modal.dart';
import 'package:split_the_bill/presentation/shared/components/headline.dart';
import 'package:split_the_bill/presentation/shared/groups/group_tile.dart';
import 'package:split_the_bill/router/routes.dart';

class GroupSelectionScreen extends ConsumerStatefulWidget {
  const GroupSelectionScreen({super.key});

  @override
  ConsumerState<GroupSelectionScreen> createState() =>
      _GroupSelectionScreenState();
}

class _GroupSelectionScreenState extends ConsumerState<GroupSelectionScreen> {
  final ScrollController scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  Future _getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    setState(() {
      if (image != null) {
        _image = image;
        ref.watch(billRecognitionProvider.notifier).runBillRecognition(_image);
        const RecognizedBillRoute().push(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Bill"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Headline(title: "Select a group"),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  Consumer(
                    builder: (context, ref, _) {
                      final groups = ref.watch(groupsStateProvider);
                      return AsyncValueSliverWidget(
                        value: groups,
                        data: (groups) => SliverToBoxAdapter(
                          child: _buildGroupsListView(context, ref, groups),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupsListView(
      BuildContext context, WidgetRef ref, List<Group> groups) {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: true,
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];
        return _buildGroupTile(context, ref, group);
      },
    );
  }

  Widget _buildGroupTile(BuildContext context, WidgetRef ref, Group group) {
    return GroupTile(
      group: group,
      onTap: () {
        showBottomModal(
          context,
          "Add New Bill",
          NewBillModal(
            getImage: _getImage,
            group: group,
          ),
        );
      },
      isDetailed: false,
    );
  }
}

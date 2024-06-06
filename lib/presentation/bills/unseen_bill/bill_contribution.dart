import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/ui_constants.dart';
import 'package:split_the_bill/domain/bill/bill.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/controllers.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/item_contribution.dart';
import 'package:split_the_bill/presentation/shared/components/fade_text.dart';

class BillContribution extends ConsumerStatefulWidget {
  const BillContribution({
    super.key,
    required this.bill,
  });

  final Bill bill;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BillContributionState();
}

class _BillContributionState extends ConsumerState<BillContribution> {
  late List<bool> expandedItems;
  int focusIndex = 0;
  final ScrollController _controller = ScrollController();
  late List<GlobalKey> _keys;

  @override
  void initState() {
    super.initState();
    expandedItems =
        List.generate(widget.bill.items.length, (index) => index == 0);
    _keys = List.generate(widget.bill.items.length, (index) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
    final itemContributions =
        ref.watch(itemsContributionsProvider(widget.bill));
    final items = widget.bill.items;

    return Padding(
      padding: const EdgeInsets.all(Sizes.p24),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: items.length,
              itemBuilder: (context, index) {
                if (index < items.length) {
                  return ItemContributionDecoration(
                    key: _keys[index],
                    borderColor:
                        expandedItems[index] ? Colors.grey : Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () {
                            _scrollIntoView(index);
                            setState(() {
                              expandedItems[index] = !expandedItems[index];
                            });
                          },
                          leading: const Icon(
                            Icons.inventory,
                            color: Colors.blue,
                          ),
                          title: FadeText(
                            text: items[index].name,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          trailing: itemContributions[index].contributed
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                        ),
                        if (expandedItems[index]) ...[
                          const Divider(),
                          ItemContribution(
                            updateContribution: _updateContributionStatus,
                            item: items[index],
                            index: index,
                          )
                        ],
                      ],
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  // Update contribution status for the current user on the specified item
  void _updateContributionStatus(bool isContributing, int index) async {
    setState(() {
      focusIndex = index;
      _scrollToTop(index);
      expandedItems =
          List.generate(expandedItems.length, (i) => i == index + 1);
    });

    // Notify the provider about the updated item contribution
    ref
        .read(itemsContributionsProvider(widget.bill).notifier)
        .setItemContribution(widget.bill.items[index].id, isContributing);
  }

  void _scrollToTop(int index) {
    // Ensure the target widget is visible
    final RenderBox childRenderBox =
        _keys[index].currentContext!.findRenderObject() as RenderBox;
    final RenderBox parentRenderBox =
        _controller.position.context.storageContext.findRenderObject()
            as RenderBox;
    final double childOffset =
        childRenderBox.localToGlobal(Offset.zero, ancestor: parentRenderBox).dy;

    _controller.animateTo(
      _controller.offset + childOffset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _scrollIntoView(int index) {
    setState(() {
      focusIndex = index;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox childRenderBox =
          _keys[index].currentContext!.findRenderObject() as RenderBox;
      final RenderBox parentRenderBox =
          _controller.position.context.storageContext.findRenderObject()
              as RenderBox;
      final double childTop = childRenderBox
          .localToGlobal(Offset.zero, ancestor: parentRenderBox)
          .dy;
      final double childBottom = childRenderBox
          .localToGlobal(Offset(0, childRenderBox.size.height),
              ancestor: parentRenderBox)
          .dy;
      final double parentTop = parentRenderBox.localToGlobal(Offset.zero).dy;
      final double parentBottom = parentRenderBox
          .localToGlobal(Offset(0, parentRenderBox.size.height),
              ancestor: parentRenderBox)
          .dy;
      final double deltaTop = childTop - parentTop;
      final double deltaBottom = childBottom - parentBottom;

      // Ensure child widget is fully visible within its parent's viewport
      Scrollable.ensureVisible(
        _keys[index].currentContext!,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );

      // Calculate additional scroll offset if child widget extends beyond parent's viewport
      double additionalOffset = 0;
      if (deltaTop < 0) {
        additionalOffset = deltaTop;
      } else if (deltaBottom > 0) {
        additionalOffset = deltaBottom;
      }

      _controller.animateTo(
        _controller.offset + additionalOffset,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }
}

class ItemContributionDecoration extends StatelessWidget {
  const ItemContributionDecoration({
    super.key,
    required this.child,
    required this.borderColor,
  });

  final Widget child;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.p8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(Sizes.p12),
        ),
        child: child,
      ),
    );
  }
}

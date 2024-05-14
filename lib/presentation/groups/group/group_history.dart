import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/ui_constants.dart';

class GroupHistory extends StatelessWidget {
  const GroupHistory({super.key});

  @override
  Widget build(BuildContext context) {
    List<GroupHistoryItem> historyItems = [
      GroupHistoryItem(
        action: "was tired and left the",
        actor: "Jan",
        target: "group",
        date: "2024-01-22",
        icon: "time_to_leave",
      ),
      GroupHistoryItem(
        action: "paid 0,35 € to",
        actor: "Marvin",
        target: "Felix",
        date: "2024-01-21",
        icon: "attach_money",
      ),
      GroupHistoryItem(
        action: "splitted a new bill:",
        actor: "Felix",
        target: "Shisha tabak",
        date: "2024-01-20",
        icon: "add",
      ),
      GroupHistoryItem(
        action: "joined the",
        actor: "Marvin",
        target: "group",
        date: "2024-01-19",
        icon: "group_add",
      ),
      GroupHistoryItem(
        action: "created the",
        actor: "Felix",
        target: "group",
        date: "2024-01-18",
        icon: "create",
      ),
      // Add more history items as needed
    ];

    Map<String, IconData> iconDataMap = {
      'create': Icons.create,
      'add': Icons.add,
      'attach_money': Icons.attach_money,
      'group_add': Icons.group_add,
      'time_to_leave': Icons.time_to_leave,
      // Add more mappings as needed
    };

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p24,
        vertical: Sizes.p16,
      ),
      child: ListView.builder(
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              iconDataMap[historyItems[index].icon],
            ),
            title: buildHistoryText(historyItems[index]),
            subtitle: Text(
              historyItems[index].date,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }

  RichText buildHistoryText(GroupHistoryItem historyItem) {
    String action = historyItem.action;
    String actor = historyItem.actor;
    String target = historyItem.target;

    TextSpan actionSpan = TextSpan(
      text: action,
    );

    TextSpan actorSpan = TextSpan(
      text: '$actor ',
      style: const TextStyle(fontWeight: FontWeight.bold),
    );

    TextSpan targetSpan = TextSpan(
      text: ' $target.',
      style: const TextStyle(fontWeight: FontWeight.bold),
    );

    List<TextSpan> textSpans = [
      actorSpan,
      actionSpan,
      targetSpan,
    ];

    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: textSpans,
      ),
    );
  }
}

class GroupHistoryItem {
  final String action;
  final String actor;
  final String target;
  final String date;
  final String icon;

  GroupHistoryItem({
    required this.action,
    required this.actor,
    required this.target,
    required this.date,
    required this.icon,
  });
}

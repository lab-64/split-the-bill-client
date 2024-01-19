import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:split_the_bill/constants/app_sizes.dart';
import 'package:split_the_bill/domain/group/group.dart';
import 'package:split_the_bill/presentation/groups/groups/controllers.dart';

class GroupTile extends ConsumerWidget {
  const GroupTile({super.key, required this.group, this.onTap});

  final Group group;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: Sizes.p16),
      elevation: 0.5,
      child: ListTile(
        contentPadding: const EdgeInsets.all(Sizes.p16),
        leading: Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Colors.purple.shade300, Colors.purple.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        title: Text(
          group.name,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        subtitle: Row(
          children: [
            for (var member in group.members)
              const Padding(
                padding: EdgeInsets.only(right: 4.0),
                child: CircleAvatar(
                  radius: 10.0,
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                ),
              ),
          ],
        ),
        trailing: const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: Sizes.p8),
              child: Text(
                "343 €",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            Icon(Icons.navigate_next),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

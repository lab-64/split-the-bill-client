import 'package:flutter/material.dart';
import 'package:split_the_bill/constants/app_sizes.dart';

class GroupsAppBar extends StatelessWidget {
  const GroupsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                ),
                gapW16,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back!',
                      style: TextStyle(),
                    ),
                    Text(
                      'Felix',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  /*
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      expandedHeight: 120,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Colors.blue[700],
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 3,
              blurRadius: 7,
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GroupsAppBarGreeting(),
            GroupsAppBarBalance(),
          ],
        ),
      ),
    );
  }

   */
}

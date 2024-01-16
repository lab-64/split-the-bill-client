import 'package:flutter/material.dart';
import 'package:split_the_bill/presentation/groups/groups/add_new_group_button.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_list.dart';

import 'app_bar/groups_app_bar.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      /*
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.blue, // Set your desired background color
          elevation: 0, // Remove the shadow
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                        'https://example.com/path/to/your/image.jpg'),
                    // or you can use AssetImage for local images
                    // backgroundImage: AssetImage('assets/your_image.png'),
                  ),
                  SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
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
                icon: Icon(Icons.settings),
                onPressed: () {
                  // Handle settings icon click
                },
              ),
            ],
          ),
        ),
      ),

       */
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const GroupsAppBar(),
            const AddNewGroupButton(),
            GroupsList(scrollController: scrollController),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/presentation/bills/bill/bill_screen.dart';
import 'package:split_the_bill/presentation/bills/bills/bills_screen.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_screen.dart';
import 'package:split_the_bill/presentation/groups/new_group/new_group_screen.dart';
import 'package:split_the_bill/presentation/new_bill/new_bill_screen.dart';
import 'package:split_the_bill/presentation/on_boarding/sign_in_screen.dart';
import 'package:split_the_bill/presentation/shared/navigation/navigation.dart';

import 'presentation/groups/group_item/group_item_screen.dart';

part 'routes.g.dart';

enum Routes { groups, group, newGroup, bills, bill, signIn, newBill }

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final authService = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/groups',
    redirect: (context, state) {
      final isLoggedIn = authService.value!.id.isNotEmpty;
      final path = state.uri.path;
      if (isLoggedIn) {
        if (path == '/signIn') {
          return '/';
        }
      } else {
        return '/signIn';
      }

      return null;
    },
    routes: [
      ShellRoute(
        builder: (
          BuildContext context,
          GoRouterState state,
          Widget child,
        ) {
          final isGroupsOrBillsRoute =
              state.uri.path == '/groups' || state.uri.path == '/bills';

          if (isGroupsOrBillsRoute) {
            return Navigation(child: child);
          } else {
            return Scaffold(
              body: child,
            );
          }
        },
        routes: [
          GoRoute(
            path: '/groups',
            name: Routes.groups.name,
            builder: (context, state) => const GroupsScreen(),
            routes: [
              GoRoute(
                path: 'new',
                name: Routes.newGroup.name,
                builder: (context, state) => const NewGroupScreen(),
              ),
              GoRoute(
                  path: ':id',
                  name: Routes.group.name,
                  builder: (context, state) {
                    final groupId = state.pathParameters['id']!;
                    return GroupItemScreen(groupId: groupId);
                  },
                  routes: [
                    GoRoute(
                      path: ':billId',
                      name: Routes.bill.name,
                      builder: (context, state) {
                        final billId = state.pathParameters["billId"]!;
                        return BillItemScreen(billId: billId);
                      },
                    ),
                  ]),
            ],
          ),
          GoRoute(
            path: '/bills',
            name: Routes.bills.name,
            builder: (context, state) => const BillsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/new_bill',
        name: Routes.newBill.name,
        builder: (context, state) => const NewBillScreen(),
      ),
      GoRoute(
        path: '/signIn',
        name: Routes.signIn.name,
        builder: (context, state) => const SignInScreen(),
      ),
    ],
  );
}

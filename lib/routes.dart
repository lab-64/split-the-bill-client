import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/presentation/bills/bill/bill_screen.dart';
import 'package:split_the_bill/presentation/bills/bills/bills_screen.dart';
import 'package:split_the_bill/presentation/bills/edit_bill/edit_bill_screen.dart';
import 'package:split_the_bill/presentation/groups/group/group_screen.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_screen.dart';
import 'package:split_the_bill/presentation/groups/new_group/new_group_screen.dart';
import 'package:split_the_bill/presentation/home/home_screen.dart';
import 'package:split_the_bill/presentation/on_boarding/sign_in_screen.dart';
import 'package:split_the_bill/presentation/profile/profile_screen.dart';
import 'package:split_the_bill/presentation/shared/navigation/navigation.dart';

part 'routes.g.dart';

enum Routes {
  // HOME
  home,
  homeGroup,
  homeBill,

  // SIGN IN
  signIn,

  // GROUP
  groups,
  group,
  newGroup,

  // BILL
  bills,
  bill,
  editBill,
  newBill,

  // PROFILE
  profile
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final authService = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/home',
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
          final isMainRoute = state.uri.path == '/home' ||
              state.uri.path == '/groups' ||
              state.uri.path == '/bills' ||
              state.uri.path == '/profile';

          if (isMainRoute) {
            return Navigation(child: child);
          } else {
            return Scaffold(
              body: child,
            );
          }
        },
        routes: [
          GoRoute(
            path: '/home',
            name: Routes.home.name,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'group/:groupId',
                name: Routes.homeGroup.name,
                builder: (context, state) {
                  final groupId = state.pathParameters['groupId']!;
                  return GroupScreen(groupId: groupId);
                },
              ),
              GoRoute(
                path: 'bill/:billId',
                name: Routes.homeBill.name,
                builder: (context, state) {
                  final billId = state.pathParameters["billId"]!;
                  return BillScreen(billId: billId);
                },
              ),
              GoRoute(
                path: 'new_bill',
                name: Routes.newBill.name,
                builder: (context, state) => const EditBillScreen(billId: '0'),
              ),
            ],
          ),
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
                path: ':groupId',
                name: Routes.group.name,
                builder: (context, state) {
                  final groupId = state.pathParameters['groupId']!;
                  return GroupScreen(groupId: groupId);
                },
                routes: [
                  GoRoute(
                    path: ':billId',
                    name: Routes.bill.name,
                    builder: (context, state) {
                      final billId = state.pathParameters["billId"]!;
                      return BillScreen(billId: billId);
                    },
                    /*
                    routes: [
                      GoRoute(
                          path: 'edit',
                          name: Routes.editBill.name,
                          builder: (context, state) {
                            final billId = state.pathParameters["billId"]!;
                            return EditBillScreen(billId: billId);
                          }),
                    ],

                     */
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/bills',
            name: Routes.bills.name,
            builder: (context, state) => const BillsScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: Routes.profile.name,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/signIn',
        name: Routes.signIn.name,
        builder: (context, state) => const SignInScreen(),
      ),
    ],
  );
}

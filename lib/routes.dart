import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/presentation/bills/bill/bill_screen.dart';
import 'package:split_the_bill/presentation/bills/bills/bills_screen.dart';
import 'package:split_the_bill/presentation/bills/new_bill/group_selection_screen.dart';
import 'package:split_the_bill/presentation/bills/new_bill/new_bill_screen.dart';
import 'package:split_the_bill/presentation/groups/group/group_screen.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_screen.dart';
import 'package:split_the_bill/presentation/groups/new_group/new_group_screen.dart';
import 'package:split_the_bill/presentation/home/home_screen.dart';
import 'package:split_the_bill/presentation/on_boarding/register.dart';
import 'package:split_the_bill/presentation/on_boarding/sign_in_screen.dart';
import 'package:split_the_bill/presentation/profile/edit_profile/edit_profile_screen.dart';
import 'package:split_the_bill/presentation/profile/profile/profile_screen.dart';
import 'package:split_the_bill/presentation/shared/navigation/navigation.dart';

part 'routes.g.dart';

enum NavbarRoutes {
  home,
  groups,
  bills,
  profile,
}

enum Routes {
  // HOME
  homeGroup,
  homeBill,
  homeGroupBill,
  homeGroupNewBill,
  homeEditProfile,

  // SIGN IN
  signIn,

  //REGISTER
  register,

  // GROUP
  group,
  newGroup,

  // BILL
  bill,
  editBill,
  newBillGroupSelection,
  newBill,
}

final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  // Listen to the auth state
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  ref
    ..onDispose(isAuth.dispose)
    ..listen(
      authStateProvider
          .select((value) => value.whenData((value) => value.id.isNotEmpty)),
      (_, next) {
        isAuth.value = next;
      },
    );

  return GoRouter(
    navigatorKey: routerKey,
    debugLogDiagnostics: false,
    refreshListenable: isAuth,
    initialLocation: '/signIn',
    redirect: (context, state) {
      // Redirect the user to the correct route based on their auth status
      if (isAuth.value.isLoading || !isAuth.value.hasValue) return null;

      final isLoggedIn = isAuth.value.requireValue;
      final path = state.uri.path;

      if (!isLoggedIn) {
        return "/signIn";
      }

      if (isLoggedIn && (path == "/signIn" || path == "/register")) {
        return "/home";
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
            name: NavbarRoutes.home.name,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'group/:groupId',
                name: Routes.homeGroup.name,
                builder: (context, state) {
                  final groupId = state.pathParameters['groupId']!;
                  return GroupScreen(groupId: groupId);
                },
                routes: [
                  GoRoute(
                    path: 'bill/:billId',
                    name: Routes.homeGroupBill.name,
                    builder: (context, state) {
                      final billId = state.pathParameters["billId"]!;
                      return BillScreen(billId: billId);
                    },
                  ),
                  GoRoute(
                    path: 'new_bill',
                    name: Routes.homeGroupNewBill.name,
                    builder: (context, state) {
                      final groupId = state.pathParameters['groupId']!;
                      return NewBillScreen(groupId: groupId);
                    },
                  ),
                ],
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
                name: Routes.newBillGroupSelection.name,
                builder: (context, state) => GroupSelectionScreen(),
                routes: [
                  GoRoute(
                    path: 'new_bill/:groupId',
                    name: Routes.newBill.name,
                    builder: (context, state) {
                      final groupId = state.pathParameters["groupId"]!;
                      return NewBillScreen(groupId: groupId);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/groups',
            name: NavbarRoutes.groups.name,
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
            name: NavbarRoutes.bills.name,
            builder: (context, state) => const BillsScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: NavbarRoutes.profile.name,
            builder: (context, state) => const ProfileScreen(),
            routes: [
              GoRoute(
                path: 'edit',
                name: Routes.homeEditProfile.name,
                builder: (context, state) => const EditProfileScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/register',
            name: Routes.register.name,
            builder: (context, state) => const RegisterScreen(),
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

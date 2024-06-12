import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/presentation/bills/bill/bill_screen.dart';
import 'package:split_the_bill/presentation/bills/new_bill/group_selection_screen.dart';
import 'package:split_the_bill/presentation/bills/new_bill/edit_bill_screen.dart';
import 'package:split_the_bill/presentation/camera/image_cropping/img_crop_screen.dart';
import 'package:split_the_bill/presentation/bills/unseen_bill/unseen_bill_screen.dart';
import 'package:split_the_bill/presentation/groups/edit_group/edit_group_screen.dart';
import 'package:split_the_bill/presentation/groups/group/group_screen.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_screen.dart';
import 'package:split_the_bill/presentation/home/home_screen.dart';
import 'package:split_the_bill/presentation/on_boarding/register.dart';
import 'package:split_the_bill/presentation/on_boarding/sign_in_screen.dart';
import 'package:split_the_bill/presentation/profile/edit_profile/edit_profile_screen.dart';
import 'package:split_the_bill/presentation/profile/profile/profile_screen.dart';
import 'package:split_the_bill/presentation/shared/navigation/navbar.dart';
import 'package:split_the_bill/presentation/transactions/transactions_screen.dart';

part 'routes.g.dart';

@TypedShellRoute<NavbarShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(
      path: '/',
    ),
    TypedGoRoute<GroupsRoute>(
      path: '/groups',
      routes: [
        TypedGoRoute<EditGroupRoute>(path: 'edit/:groupId'),
        TypedGoRoute<GroupRoute>(path: ':groupId'),
      ],
    ),
    TypedGoRoute<BillsRoute>(
      path: '/bills',
      routes: [
        TypedGoRoute<NewBillGroupSelectionRoute>(
          path: 'new',
          routes: [
            TypedGoRoute<EditBillRoute>(path: ':groupId'),
          ],
        ),
        TypedGoRoute<BillRoute>(path: ':billId'),
      ],
    ),
    TypedGoRoute<ProfileRoute>(
      path: '/profile',
      routes: [
        TypedGoRoute<EditProfileRoute>(path: 'edit'),
      ],
    ),
    TypedGoRoute<ImageCropRoute>(
      path: '/crop',
    ),
    TypedGoRoute<UnseenBillRoute>(
      path: '/unseenBills:billId',
    ),
    TypedGoRoute<TransactionRoute>(
      path: '/transactions',
    )
  ],
)
class NavbarShellRoute extends ShellRouteData {
  const NavbarShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigator,
  ) {
    final isMainRoute = state.uri.path == const HomeRoute().location ||
        state.uri.path == const GroupsRoute().location ||
        state.uri.path == const TransactionRoute().location ||
        state.uri.path == const ProfileRoute().location;

    if (isMainRoute) {
      return Navbar(child: navigator);
    } else {
      return Scaffold(
        body: navigator,
      );
    }
  }
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignInScreen();
  }
}

@TypedGoRoute<RegisterRoute>(path: '/register')
class RegisterRoute extends GoRouteData {
  const RegisterRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RegisterScreen();
  }
}

/// HOME
class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

class ImageCropRoute extends GoRouteData {
  final String imgFile;
  final String billId;

  const ImageCropRoute(this.imgFile, this.billId);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ImageCropScreen(imgFile: imgFile, billId: billId);
  }
}

/// GROUP
class GroupsRoute extends GoRouteData {
  const GroupsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const GroupsScreen();
  }
}

class GroupRoute extends GoRouteData {
  const GroupRoute({required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return GroupScreen(groupId: groupId);
  }
}

class EditGroupRoute extends GoRouteData {
  const EditGroupRoute({required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditGroupScreen(groupId: groupId);
  }
}

/// BILL
class BillsRoute extends GoRouteData {
  const BillsRoute();
}

class BillRoute extends GoRouteData {
  const BillRoute({required this.billId});

  final String billId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BillScreen(billId: billId);
  }
}

class NewBillGroupSelectionRoute extends GoRouteData {
  const NewBillGroupSelectionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return GroupSelectionScreen();
  }
}

class EditBillRoute extends GoRouteData {
  const EditBillRoute({required this.groupId, required this.billId});
  final String groupId;
  final String billId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditBillScreen(
      groupId: groupId,
      billId: billId,
    );
  }
}

/// UNSEEN BILLS
class UnseenBillRoute extends GoRouteData {
  const UnseenBillRoute({required this.billId});

  final String billId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UnseenBillScreen(billId: billId);
  }
}

/// PROFILE
class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}

class EditProfileRoute extends GoRouteData {
  const EditProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const EditProfileScreen();
  }
}

/// TRANSACTIONS
class TransactionRoute extends GoRouteData {
  const TransactionRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TransactionScreen();
  }
}

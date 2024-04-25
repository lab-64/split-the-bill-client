import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_the_bill/presentation/bills/bill/bill_screen.dart';
import 'package:split_the_bill/presentation/bills/bills/bills_screen.dart';
import 'package:split_the_bill/presentation/bills/new_bill/group_selection_screen.dart';
import 'package:split_the_bill/presentation/bills/new_bill/new_bill_screen.dart';
import 'package:split_the_bill/presentation/camera/camera_screen.dart';
import 'package:split_the_bill/presentation/camera/image_cropping/img_crop_screen.dart';
import 'package:split_the_bill/presentation/groups/group/group_screen.dart';
import 'package:split_the_bill/presentation/groups/groups/groups_screen.dart';
import 'package:split_the_bill/presentation/groups/new_group/new_group_screen.dart';
import 'package:split_the_bill/presentation/home/home_screen.dart';
import 'package:split_the_bill/presentation/on_boarding/register.dart';
import 'package:split_the_bill/presentation/on_boarding/sign_in_screen.dart';
import 'package:split_the_bill/presentation/profile/edit_profile/edit_profile_screen.dart';
import 'package:split_the_bill/presentation/profile/profile/profile_screen.dart';
import 'package:split_the_bill/presentation/shared/navigation/navbar.dart';

part 'routes.g.dart';

@TypedShellRoute<NavbarShellRoute>(
  routes: [
    TypedGoRoute<HomeRoute>(path: '/'),
    TypedGoRoute<GroupsRoute>(
      path: '/groups',
      routes: [
        TypedGoRoute<NewGroupRoute>(path: 'new'),
        TypedGoRoute<GroupRoute>(path: ':groupId'),
      ],
    ),
    TypedGoRoute<BillsRoute>(
      path: '/bills',
      routes: [
        TypedGoRoute<NewBillGroupSelectionRoute>(
          path: 'new',
          routes: [
            TypedGoRoute<NewBillRoute>(path: ':groupId'),
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
    TypedGoRoute<CameraRoute>(
      path: '/camera'
    ),
    TypedGoRoute<ImageCropRoute>(
      path: '/crop'
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
        state.uri.path == const BillsRoute().location ||
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

// CAMERA
class CameraRoute extends GoRouteData {

  const CameraRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CameraScreen();
  }
}

class ImageCropRoute extends GoRouteData {
  final String imgFile;

  const ImageCropRoute(this.imgFile);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ImageCropScreen(imgFile: imgFile);
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

class NewGroupRoute extends GoRouteData {
  const NewGroupRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const NewGroupScreen();
  }
}

/// BILL
class BillsRoute extends GoRouteData {
  const BillsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const BillsScreen();
  }
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

class NewBillRoute extends GoRouteData {
  const NewBillRoute({required this.groupId});
  final String groupId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NewBillScreen(groupId: groupId);
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:split_the_bill/auth/states/auth_state.dart';
import 'package:split_the_bill/router/routes.dart';

part 'router.g.dart';

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

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

  final router = GoRouter(
    navigatorKey: routerKey,
    refreshListenable: isAuth,
    initialLocation: const LoginRoute().location,
    routes: $appRoutes,
    redirect: (context, state) {
      // Redirect the user to the correct route based on their auth status
      if (isAuth.value.isLoading || !isAuth.value.hasValue) return null;

      final isLoggedIn = isAuth.value.requireValue;
      final path = state.uri.path;

      if (!isLoggedIn && path != const RegisterRoute().location) {
        return const LoginRoute().location;
      }

      if (isLoggedIn &&
          (path == const LoginRoute().location ||
              path == const RegisterRoute().location)) {
        return const HomeRoute().location;
      }

      return null;
    },
  );

  ref.onDispose(router.dispose);
  return router;
}

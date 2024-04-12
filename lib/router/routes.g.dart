// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $navbarShellRoute,
      $loginRoute,
      $registerRoute,
    ];

RouteBase get $navbarShellRoute => ShellRouteData.$route(
      factory: $NavbarShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/',
          factory: $HomeRouteExtension._fromState,
        ),
        GoRouteData.$route(
          path: '/groups',
          factory: $GroupsRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'new',
              factory: $NewGroupRouteExtension._fromState,
            ),
            GoRouteData.$route(
              path: ':groupId',
              factory: $GroupRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: '/bills',
          factory: $BillsRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'new',
              factory: $NewBillGroupSelectionRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'recognized',
                  factory: $RecognizedBillRouteExtension._fromState,
                ),
                GoRouteData.$route(
                  path: ':groupId',
                  factory: $NewBillRouteExtension._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: ':billId',
              factory: $BillRouteExtension._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: '/profile',
          factory: $ProfileRouteExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: 'edit',
              factory: $EditProfileRouteExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $NavbarShellRouteExtension on NavbarShellRoute {
  static NavbarShellRoute _fromState(GoRouterState state) =>
      const NavbarShellRoute();
}

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GroupsRouteExtension on GroupsRoute {
  static GroupsRoute _fromState(GoRouterState state) => const GroupsRoute();

  String get location => GoRouteData.$location(
        '/groups',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NewGroupRouteExtension on NewGroupRoute {
  static NewGroupRoute _fromState(GoRouterState state) => const NewGroupRoute();

  String get location => GoRouteData.$location(
        '/groups/new',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $GroupRouteExtension on GroupRoute {
  static GroupRoute _fromState(GoRouterState state) => GroupRoute(
        groupId: state.pathParameters['groupId']!,
      );

  String get location => GoRouteData.$location(
        '/groups/${Uri.encodeComponent(groupId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BillsRouteExtension on BillsRoute {
  static BillsRoute _fromState(GoRouterState state) => const BillsRoute();

  String get location => GoRouteData.$location(
        '/bills',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NewBillGroupSelectionRouteExtension on NewBillGroupSelectionRoute {
  static NewBillGroupSelectionRoute _fromState(GoRouterState state) =>
      const NewBillGroupSelectionRoute();

  String get location => GoRouteData.$location(
        '/bills/new',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RecognizedBillRouteExtension on RecognizedBillRoute {
  static RecognizedBillRoute _fromState(GoRouterState state) =>
      const RecognizedBillRoute();

  String get location => GoRouteData.$location(
        '/bills/new/recognized',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $NewBillRouteExtension on NewBillRoute {
  static NewBillRoute _fromState(GoRouterState state) => NewBillRoute(
        groupId: state.pathParameters['groupId']!,
      );

  String get location => GoRouteData.$location(
        '/bills/new/${Uri.encodeComponent(groupId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $BillRouteExtension on BillRoute {
  static BillRoute _fromState(GoRouterState state) => BillRoute(
        billId: state.pathParameters['billId']!,
      );

  String get location => GoRouteData.$location(
        '/bills/${Uri.encodeComponent(billId)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ProfileRouteExtension on ProfileRoute {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  String get location => GoRouteData.$location(
        '/profile',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $EditProfileRouteExtension on EditProfileRoute {
  static EditProfileRoute _fromState(GoRouterState state) =>
      const EditProfileRoute();

  String get location => GoRouteData.$location(
        '/profile/edit',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $registerRoute => GoRouteData.$route(
      path: '/register',
      factory: $RegisterRouteExtension._fromState,
    );

extension $RegisterRouteExtension on RegisterRoute {
  static RegisterRoute _fromState(GoRouterState state) => const RegisterRoute();

  String get location => GoRouteData.$location(
        '/register',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

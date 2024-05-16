import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

const String _authCookieKey = 'AUTH_COOKIE';
const String _userKey = 'USER';
const String _currentPage = 'CURRENT_PAGE';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
SharedUtility sharedUtility(SharedUtilityRef ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: sharedPrefs);
}

class SharedUtility {
  SharedUtility({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  String getAuthCookie() {
    return sharedPreferences.getString(_authCookieKey) ?? '';
  }

  void setAuthCookie(String authCookie) {
    sharedPreferences.setString(_authCookieKey, authCookie);
  }

  String getUser() {
    return sharedPreferences.getString(_userKey) ?? '';
  }

  void setUser(String user) {
    sharedPreferences.setString(_userKey, user);
  }

  String getCurrentPage() {
    return sharedPreferences.getString(_userKey) ?? '';
  }

  void setCurrentPage(String user) {
    sharedPreferences.setString(_userKey, user);
  }
}

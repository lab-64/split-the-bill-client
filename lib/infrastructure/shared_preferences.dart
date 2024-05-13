import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

const String sharedAuthCookie = 'authCookie';

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
    return sharedPreferences.getString(sharedAuthCookie) ?? '';
  }

  void setAuthCookie(String authCookie) {
    sharedPreferences.setString(sharedAuthCookie, authCookie);
  }
}

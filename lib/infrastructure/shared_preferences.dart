import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

const String _userKey = 'USER';

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

  String getUser() {
    return sharedPreferences.getString(_userKey) ?? '';
  }

  void setUser(String user) {
    sharedPreferences.setString(_userKey, user);
  }

  void removeUser() {
    sharedPreferences.remove(_userKey);
  }
}

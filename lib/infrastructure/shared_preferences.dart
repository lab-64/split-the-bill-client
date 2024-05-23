import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

const String _userKey = 'USER';

/// A Riverpod provider for SharedPreferences.
/// It throws an [UnimplementedError] to indicate that it should be overridden in the main function
/// with the actual instance of SharedPreferences. This is done to ensure that SharedPreferences
/// is properly initialized before being used.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError();
}

/// A Riverpod provider for SharedUtility.
/// This provider depends on the [sharedPreferencesProvider] to get an instance of SharedPreferences.
/// The [SharedUtility] class provides convenient methods to interact with SharedPreferences.
@Riverpod(keepAlive: true)
SharedUtility sharedUtility(SharedUtilityRef ref) {
  // Watch the sharedPreferencesProvider to get the SharedPreferences instance
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

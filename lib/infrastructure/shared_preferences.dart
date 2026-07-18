import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_the_bill/domain/group/group.dart';

part 'shared_preferences.g.dart';

const String _userKey = 'USER';
const String _groupsKey = 'GROUPS';

/// A Riverpod provider for SharedPreferences.
/// It throws an [UnimplementedError] to indicate that it should be overridden in the main function
/// with the actual instance of SharedPreferences. This is done to ensure that SharedPreferences
/// is properly initialized before being used.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError();
}

/// A Riverpod provider for SharedUtility.
/// This provider depends on the [sharedPreferencesProvider] to get an instance of SharedPreferences.
/// The [SharedUtility] class provides convenient methods to interact with SharedPreferences.
@Riverpod(keepAlive: true)
SharedUtility sharedUtility(Ref ref) {
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

  List<Group> getGroups() {
    final jsonString = sharedPreferences.getString(_groupsKey);
    if (jsonString == null || jsonString.isEmpty) return [];
    final List<dynamic> list = jsonDecode(jsonString);
    return list.map((e) => Group.fromMap(e)).toList();
  }

  void setGroups(List<Group> groups) {
    final jsonString = jsonEncode(groups.map((g) => g.toMapOffline()).toList());
    sharedPreferences.setString(_groupsKey, jsonString);
  }

  bool isTutorialSeen(String tutorialId) {
    return sharedPreferences.getBool('TUTORIAL_$tutorialId') ?? false;
  }

  void setTutorialSeen(String tutorialId) {
    sharedPreferences.setBool('TUTORIAL_$tutorialId', true);
  }
}

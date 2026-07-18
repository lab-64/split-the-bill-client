// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_preferences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'1a6250efdc19e86c923ceb598a77ff74d64378e6';

/// A Riverpod provider for SharedPreferences.
/// It throws an [UnimplementedError] to indicate that it should be overridden in the main function
/// with the actual instance of SharedPreferences. This is done to ensure that SharedPreferences
/// is properly initialized before being used.
///
/// Copied from [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = Provider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = ProviderRef<SharedPreferences>;
String _$sharedUtilityHash() => r'601ad799a3a2e4ee14d2e5155f7aaa02d9ed045e';

/// A Riverpod provider for SharedUtility.
/// This provider depends on the [sharedPreferencesProvider] to get an instance of SharedPreferences.
/// The [SharedUtility] class provides convenient methods to interact with SharedPreferences.
///
/// Copied from [sharedUtility].
@ProviderFor(sharedUtility)
final sharedUtilityProvider = Provider<SharedUtility>.internal(
  sharedUtility,
  name: r'sharedUtilityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sharedUtilityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedUtilityRef = ProviderRef<SharedUtility>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

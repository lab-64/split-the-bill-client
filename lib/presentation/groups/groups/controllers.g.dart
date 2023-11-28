// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupsTotalBalanceHash() =>
    r'f82c3fae45038d0853f2ec06d8129187e66d875a';

/// See also [groupsTotalBalance].
@ProviderFor(groupsTotalBalance)
final groupsTotalBalanceProvider = AutoDisposeProvider<double>.internal(
  groupsTotalBalance,
  name: r'groupsTotalBalanceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groupsTotalBalanceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GroupsTotalBalanceRef = AutoDisposeProviderRef<double>;
String _$groupBalanceHash() => r'497f23a7378ad6d251685a7ca83b187af82b7fd6';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [groupBalance].
@ProviderFor(groupBalance)
const groupBalanceProvider = GroupBalanceFamily();

/// See also [groupBalance].
class GroupBalanceFamily extends Family<double> {
  /// See also [groupBalance].
  const GroupBalanceFamily();

  /// See also [groupBalance].
  GroupBalanceProvider call(
    String groupId,
  ) {
    return GroupBalanceProvider(
      groupId,
    );
  }

  @override
  GroupBalanceProvider getProviderOverride(
    covariant GroupBalanceProvider provider,
  ) {
    return call(
      provider.groupId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'groupBalanceProvider';
}

/// See also [groupBalance].
class GroupBalanceProvider extends AutoDisposeProvider<double> {
  /// See also [groupBalance].
  GroupBalanceProvider(
    String groupId,
  ) : this._internal(
          (ref) => groupBalance(
            ref as GroupBalanceRef,
            groupId,
          ),
          from: groupBalanceProvider,
          name: r'groupBalanceProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupBalanceHash,
          dependencies: GroupBalanceFamily._dependencies,
          allTransitiveDependencies:
              GroupBalanceFamily._allTransitiveDependencies,
          groupId: groupId,
        );

  GroupBalanceProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  Override overrideWith(
    double Function(GroupBalanceRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GroupBalanceProvider._internal(
        (ref) => create(ref as GroupBalanceRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<double> createElement() {
    return _GroupBalanceProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupBalanceProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GroupBalanceRef on AutoDisposeProviderRef<double> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupBalanceProviderElement extends AutoDisposeProviderElement<double>
    with GroupBalanceRef {
  _GroupBalanceProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupBalanceProvider).groupId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

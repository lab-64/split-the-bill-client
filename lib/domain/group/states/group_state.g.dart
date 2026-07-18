// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupStateHash() => r'6eb0fc277872e6cc67f9ad9b2c99c2425980238d';

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

abstract class _$GroupState extends BuildlessAutoDisposeAsyncNotifier<Group> {
  late final String groupId;

  FutureOr<Group> build(
    String groupId,
  );
}

/// See also [GroupState].
@ProviderFor(GroupState)
const groupStateProvider = GroupStateFamily();

/// See also [GroupState].
class GroupStateFamily extends Family<AsyncValue<Group>> {
  /// See also [GroupState].
  const GroupStateFamily();

  /// See also [GroupState].
  GroupStateProvider call(
    String groupId,
  ) {
    return GroupStateProvider(
      groupId,
    );
  }

  @override
  GroupStateProvider getProviderOverride(
    covariant GroupStateProvider provider,
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
  String? get name => r'groupStateProvider';
}

/// See also [GroupState].
class GroupStateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GroupState, Group> {
  /// See also [GroupState].
  GroupStateProvider(
    String groupId,
  ) : this._internal(
          () => GroupState()..groupId = groupId,
          from: groupStateProvider,
          name: r'groupStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupStateHash,
          dependencies: GroupStateFamily._dependencies,
          allTransitiveDependencies:
              GroupStateFamily._allTransitiveDependencies,
          groupId: groupId,
        );

  GroupStateProvider._internal(
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
  FutureOr<Group> runNotifierBuild(
    covariant GroupState notifier,
  ) {
    return notifier.build(
      groupId,
    );
  }

  @override
  Override overrideWith(GroupState Function() create) {
    return ProviderOverride(
      origin: this,
      override: GroupStateProvider._internal(
        () => create()..groupId = groupId,
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
  AutoDisposeAsyncNotifierProviderElement<GroupState, Group> createElement() {
    return _GroupStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupStateProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GroupStateRef on AutoDisposeAsyncNotifierProviderRef<Group> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<GroupState, Group>
    with GroupStateRef {
  _GroupStateProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupStateProvider).groupId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

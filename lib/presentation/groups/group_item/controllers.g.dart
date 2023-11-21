// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$groupBillsControllerHash() =>
    r'9a701b00519a9d66e2a9008292b619893f67edb1';

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

abstract class _$GroupBillsController
    extends BuildlessAsyncNotifier<List<Bill>> {
  late final String groupId;

  FutureOr<List<Bill>> build(
    String groupId,
  );
}

/// See also [GroupBillsController].
@ProviderFor(GroupBillsController)
const groupBillsControllerProvider = GroupBillsControllerFamily();

/// See also [GroupBillsController].
class GroupBillsControllerFamily extends Family<AsyncValue<List<Bill>>> {
  /// See also [GroupBillsController].
  const GroupBillsControllerFamily();

  /// See also [GroupBillsController].
  GroupBillsControllerProvider call(
    String groupId,
  ) {
    return GroupBillsControllerProvider(
      groupId,
    );
  }

  @override
  GroupBillsControllerProvider getProviderOverride(
    covariant GroupBillsControllerProvider provider,
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
  String? get name => r'groupBillsControllerProvider';
}

/// See also [GroupBillsController].
class GroupBillsControllerProvider
    extends AsyncNotifierProviderImpl<GroupBillsController, List<Bill>> {
  /// See also [GroupBillsController].
  GroupBillsControllerProvider(
    String groupId,
  ) : this._internal(
          () => GroupBillsController()..groupId = groupId,
          from: groupBillsControllerProvider,
          name: r'groupBillsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$groupBillsControllerHash,
          dependencies: GroupBillsControllerFamily._dependencies,
          allTransitiveDependencies:
              GroupBillsControllerFamily._allTransitiveDependencies,
          groupId: groupId,
        );

  GroupBillsControllerProvider._internal(
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
  FutureOr<List<Bill>> runNotifierBuild(
    covariant GroupBillsController notifier,
  ) {
    return notifier.build(
      groupId,
    );
  }

  @override
  Override overrideWith(GroupBillsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GroupBillsControllerProvider._internal(
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
  AsyncNotifierProviderElement<GroupBillsController, List<Bill>>
      createElement() {
    return _GroupBillsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GroupBillsControllerProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GroupBillsControllerRef on AsyncNotifierProviderRef<List<Bill>> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GroupBillsControllerProviderElement
    extends AsyncNotifierProviderElement<GroupBillsController, List<Bill>>
    with GroupBillsControllerRef {
  _GroupBillsControllerProviderElement(super.provider);

  @override
  String get groupId => (origin as GroupBillsControllerProvider).groupId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

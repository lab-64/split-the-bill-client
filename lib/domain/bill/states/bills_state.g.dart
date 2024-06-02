// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$billsStateHash() => r'a6cdc8ddf42b0f77aedcfccf9ac0e06b31d9e1d7';

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

abstract class _$BillsState
    extends BuildlessAutoDisposeAsyncNotifier<List<Bill>> {
  late final bool isUnseen;

  FutureOr<List<Bill>> build({
    bool isUnseen = false,
  });
}

/// See also [BillsState].
@ProviderFor(BillsState)
const billsStateProvider = BillsStateFamily();

/// See also [BillsState].
class BillsStateFamily extends Family<AsyncValue<List<Bill>>> {
  /// See also [BillsState].
  const BillsStateFamily();

  /// See also [BillsState].
  BillsStateProvider call({
    bool isUnseen = false,
  }) {
    return BillsStateProvider(
      isUnseen: isUnseen,
    );
  }

  @override
  BillsStateProvider getProviderOverride(
    covariant BillsStateProvider provider,
  ) {
    return call(
      isUnseen: provider.isUnseen,
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
  String? get name => r'billsStateProvider';
}

/// See also [BillsState].
class BillsStateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BillsState, List<Bill>> {
  /// See also [BillsState].
  BillsStateProvider({
    bool isUnseen = false,
  }) : this._internal(
          () => BillsState()..isUnseen = isUnseen,
          from: billsStateProvider,
          name: r'billsStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$billsStateHash,
          dependencies: BillsStateFamily._dependencies,
          allTransitiveDependencies:
              BillsStateFamily._allTransitiveDependencies,
          isUnseen: isUnseen,
        );

  BillsStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.isUnseen,
  }) : super.internal();

  final bool isUnseen;

  @override
  FutureOr<List<Bill>> runNotifierBuild(
    covariant BillsState notifier,
  ) {
    return notifier.build(
      isUnseen: isUnseen,
    );
  }

  @override
  Override overrideWith(BillsState Function() create) {
    return ProviderOverride(
      origin: this,
      override: BillsStateProvider._internal(
        () => create()..isUnseen = isUnseen,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        isUnseen: isUnseen,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BillsState, List<Bill>>
      createElement() {
    return _BillsStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BillsStateProvider && other.isUnseen == isUnseen;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isUnseen.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BillsStateRef on AutoDisposeAsyncNotifierProviderRef<List<Bill>> {
  /// The parameter `isUnseen` of this provider.
  bool get isUnseen;
}

class _BillsStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BillsState, List<Bill>>
    with BillsStateRef {
  _BillsStateProviderElement(super.provider);

  @override
  bool get isUnseen => (origin as BillsStateProvider).isUnseen;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

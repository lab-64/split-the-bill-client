// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$billStateHash() => r'be7cac7ce39ae57c6b638a6ab93fc98cc6fd33b8';

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

abstract class _$BillState extends BuildlessAutoDisposeAsyncNotifier<Bill> {
  late final String billId;

  FutureOr<Bill> build(
    String billId,
  );
}

/// See also [BillState].
@ProviderFor(BillState)
const billStateProvider = BillStateFamily();

/// See also [BillState].
class BillStateFamily extends Family<AsyncValue<Bill>> {
  /// See also [BillState].
  const BillStateFamily();

  /// See also [BillState].
  BillStateProvider call(
    String billId,
  ) {
    return BillStateProvider(
      billId,
    );
  }

  @override
  BillStateProvider getProviderOverride(
    covariant BillStateProvider provider,
  ) {
    return call(
      provider.billId,
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
  String? get name => r'billStateProvider';
}

/// See also [BillState].
class BillStateProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BillState, Bill> {
  /// See also [BillState].
  BillStateProvider(
    String billId,
  ) : this._internal(
          () => BillState()..billId = billId,
          from: billStateProvider,
          name: r'billStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$billStateHash,
          dependencies: BillStateFamily._dependencies,
          allTransitiveDependencies: BillStateFamily._allTransitiveDependencies,
          billId: billId,
        );

  BillStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.billId,
  }) : super.internal();

  final String billId;

  @override
  FutureOr<Bill> runNotifierBuild(
    covariant BillState notifier,
  ) {
    return notifier.build(
      billId,
    );
  }

  @override
  Override overrideWith(BillState Function() create) {
    return ProviderOverride(
      origin: this,
      override: BillStateProvider._internal(
        () => create()..billId = billId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        billId: billId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<BillState, Bill> createElement() {
    return _BillStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BillStateProvider && other.billId == billId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, billId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BillStateRef on AutoDisposeAsyncNotifierProviderRef<Bill> {
  /// The parameter `billId` of this provider.
  String get billId;
}

class _BillStateProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BillState, Bill>
    with BillStateRef {
  _BillStateProviderElement(super.provider);

  @override
  String get billId => (origin as BillStateProvider).billId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

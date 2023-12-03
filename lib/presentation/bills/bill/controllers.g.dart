// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$billItemsControllerHash() =>
    r'f5097df01aad954c6026605106bd88d225034bd0';

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

abstract class _$BillItemsController
    extends BuildlessAsyncNotifier<List<Item>> {
  late final String billId;

  FutureOr<List<Item>> build(
    String billId,
  );
}

/// See also [BillItemsController].
@ProviderFor(BillItemsController)
const billItemsControllerProvider = BillItemsControllerFamily();

/// See also [BillItemsController].
class BillItemsControllerFamily extends Family<AsyncValue<List<Item>>> {
  /// See also [BillItemsController].
  const BillItemsControllerFamily();

  /// See also [BillItemsController].
  BillItemsControllerProvider call(
    String billId,
  ) {
    return BillItemsControllerProvider(
      billId,
    );
  }

  @override
  BillItemsControllerProvider getProviderOverride(
    covariant BillItemsControllerProvider provider,
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
  String? get name => r'billItemsControllerProvider';
}

/// See also [BillItemsController].
class BillItemsControllerProvider
    extends AsyncNotifierProviderImpl<BillItemsController, List<Item>> {
  /// See also [BillItemsController].
  BillItemsControllerProvider(
    String billId,
  ) : this._internal(
          () => BillItemsController()..billId = billId,
          from: billItemsControllerProvider,
          name: r'billItemsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$billItemsControllerHash,
          dependencies: BillItemsControllerFamily._dependencies,
          allTransitiveDependencies:
              BillItemsControllerFamily._allTransitiveDependencies,
          billId: billId,
        );

  BillItemsControllerProvider._internal(
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
  FutureOr<List<Item>> runNotifierBuild(
    covariant BillItemsController notifier,
  ) {
    return notifier.build(
      billId,
    );
  }

  @override
  Override overrideWith(BillItemsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: BillItemsControllerProvider._internal(
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
  AsyncNotifierProviderElement<BillItemsController, List<Item>>
      createElement() {
    return _BillItemsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BillItemsControllerProvider && other.billId == billId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, billId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin BillItemsControllerRef on AsyncNotifierProviderRef<List<Item>> {
  /// The parameter `billId` of this provider.
  String get billId;
}

class _BillItemsControllerProviderElement
    extends AsyncNotifierProviderElement<BillItemsController, List<Item>>
    with BillItemsControllerRef {
  _BillItemsControllerProviderElement(super.provider);

  @override
  String get billId => (origin as BillItemsControllerProvider).billId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

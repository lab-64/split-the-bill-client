// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editBillControllerHash() =>
    r'c7b193fe5e693adc62c5eabb07613b678ca73c02';

/// See also [EditBillController].
@ProviderFor(EditBillController)
final editBillControllerProvider =
    AsyncNotifierProvider<EditBillController, void>.internal(
  EditBillController.new,
  name: r'editBillControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$editBillControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$EditBillController = AsyncNotifier<void>;
String _$itemsHash() => r'c76b73c8f869e11eca9305614a0e90c517e16a05';

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

abstract class _$Items extends BuildlessAutoDisposeNotifier<List<Item>> {
  late final String billId;

  List<Item> build(
    String billId,
  );
}

/// See also [Items].
@ProviderFor(Items)
const itemsProvider = ItemsFamily();

/// See also [Items].
class ItemsFamily extends Family<List<Item>> {
  /// See also [Items].
  const ItemsFamily();

  /// See also [Items].
  ItemsProvider call(
    String billId,
  ) {
    return ItemsProvider(
      billId,
    );
  }

  @override
  ItemsProvider getProviderOverride(
    covariant ItemsProvider provider,
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
  String? get name => r'itemsProvider';
}

/// See also [Items].
class ItemsProvider extends AutoDisposeNotifierProviderImpl<Items, List<Item>> {
  /// See also [Items].
  ItemsProvider(
    String billId,
  ) : this._internal(
          () => Items()..billId = billId,
          from: itemsProvider,
          name: r'itemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemsHash,
          dependencies: ItemsFamily._dependencies,
          allTransitiveDependencies: ItemsFamily._allTransitiveDependencies,
          billId: billId,
        );

  ItemsProvider._internal(
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
  List<Item> runNotifierBuild(
    covariant Items notifier,
  ) {
    return notifier.build(
      billId,
    );
  }

  @override
  Override overrideWith(Items Function() create) {
    return ProviderOverride(
      origin: this,
      override: ItemsProvider._internal(
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
  AutoDisposeNotifierProviderElement<Items, List<Item>> createElement() {
    return _ItemsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemsProvider && other.billId == billId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, billId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemsRef on AutoDisposeNotifierProviderRef<List<Item>> {
  /// The parameter `billId` of this provider.
  String get billId;
}

class _ItemsProviderElement
    extends AutoDisposeNotifierProviderElement<Items, List<Item>>
    with ItemsRef {
  _ItemsProviderElement(super.provider);

  @override
  String get billId => (origin as ItemsProvider).billId;
}

String _$billRecognitionHash() => r'5d7ecf0926274974e5d67272655ab1c812b5fa5a';

/// See also [BillRecognition].
@ProviderFor(BillRecognition)
final billRecognitionProvider =
    AutoDisposeAsyncNotifierProvider<BillRecognition, BillSuggestion>.internal(
  BillRecognition.new,
  name: r'billRecognitionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$billRecognitionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BillRecognition = AutoDisposeAsyncNotifier<BillSuggestion>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

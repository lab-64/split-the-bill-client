// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemStateHash() => r'884f46efbb562b6441b715d56fe6908ead25a0fa';

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

abstract class _$ItemState extends BuildlessAsyncNotifier<Item> {
  late final String itemId;

  FutureOr<Item> build(
    String itemId,
  );
}

/// See also [ItemState].
@ProviderFor(ItemState)
const itemStateProvider = ItemStateFamily();

/// See also [ItemState].
class ItemStateFamily extends Family<AsyncValue<Item>> {
  /// See also [ItemState].
  const ItemStateFamily();

  /// See also [ItemState].
  ItemStateProvider call(
    String itemId,
  ) {
    return ItemStateProvider(
      itemId,
    );
  }

  @override
  ItemStateProvider getProviderOverride(
    covariant ItemStateProvider provider,
  ) {
    return call(
      provider.itemId,
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
  String? get name => r'itemStateProvider';
}

/// See also [ItemState].
class ItemStateProvider extends AsyncNotifierProviderImpl<ItemState, Item> {
  /// See also [ItemState].
  ItemStateProvider(
    String itemId,
  ) : this._internal(
          () => ItemState()..itemId = itemId,
          from: itemStateProvider,
          name: r'itemStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemStateHash,
          dependencies: ItemStateFamily._dependencies,
          allTransitiveDependencies: ItemStateFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  ItemStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  FutureOr<Item> runNotifierBuild(
    covariant ItemState notifier,
  ) {
    return notifier.build(
      itemId,
    );
  }

  @override
  Override overrideWith(ItemState Function() create) {
    return ProviderOverride(
      origin: this,
      override: ItemStateProvider._internal(
        () => create()..itemId = itemId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<ItemState, Item> createElement() {
    return _ItemStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemStateProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemStateRef on AsyncNotifierProviderRef<Item> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _ItemStateProviderElement
    extends AsyncNotifierProviderElement<ItemState, Item> with ItemStateRef {
  _ItemStateProviderElement(super.provider);

  @override
  String get itemId => (origin as ItemStateProvider).itemId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

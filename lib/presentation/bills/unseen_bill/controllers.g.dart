// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$itemsContributionsHash() =>
    r'9065c08a69e204d210c58a313874019cc8b0189f';

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

abstract class _$ItemsContributions
    extends BuildlessAutoDisposeNotifier<List<ItemContribution>> {
  late final Bill bill;

  List<ItemContribution> build(
    Bill bill,
  );
}

/// See also [ItemsContributions].
@ProviderFor(ItemsContributions)
const itemsContributionsProvider = ItemsContributionsFamily();

/// See also [ItemsContributions].
class ItemsContributionsFamily extends Family<List<ItemContribution>> {
  /// See also [ItemsContributions].
  const ItemsContributionsFamily();

  /// See also [ItemsContributions].
  ItemsContributionsProvider call(
    Bill bill,
  ) {
    return ItemsContributionsProvider(
      bill,
    );
  }

  @override
  ItemsContributionsProvider getProviderOverride(
    covariant ItemsContributionsProvider provider,
  ) {
    return call(
      provider.bill,
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
  String? get name => r'itemsContributionsProvider';
}

/// See also [ItemsContributions].
class ItemsContributionsProvider extends AutoDisposeNotifierProviderImpl<
    ItemsContributions, List<ItemContribution>> {
  /// See also [ItemsContributions].
  ItemsContributionsProvider(
    Bill bill,
  ) : this._internal(
          () => ItemsContributions()..bill = bill,
          from: itemsContributionsProvider,
          name: r'itemsContributionsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemsContributionsHash,
          dependencies: ItemsContributionsFamily._dependencies,
          allTransitiveDependencies:
              ItemsContributionsFamily._allTransitiveDependencies,
          bill: bill,
        );

  ItemsContributionsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bill,
  }) : super.internal();

  final Bill bill;

  @override
  List<ItemContribution> runNotifierBuild(
    covariant ItemsContributions notifier,
  ) {
    return notifier.build(
      bill,
    );
  }

  @override
  Override overrideWith(ItemsContributions Function() create) {
    return ProviderOverride(
      origin: this,
      override: ItemsContributionsProvider._internal(
        () => create()..bill = bill,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bill: bill,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ItemsContributions, List<ItemContribution>>
      createElement() {
    return _ItemsContributionsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemsContributionsProvider && other.bill == bill;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bill.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ItemsContributionsRef
    on AutoDisposeNotifierProviderRef<List<ItemContribution>> {
  /// The parameter `bill` of this provider.
  Bill get bill;
}

class _ItemsContributionsProviderElement
    extends AutoDisposeNotifierProviderElement<ItemsContributions,
        List<ItemContribution>> with ItemsContributionsRef {
  _ItemsContributionsProviderElement(super.provider);

  @override
  Bill get bill => (origin as ItemsContributionsProvider).bill;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

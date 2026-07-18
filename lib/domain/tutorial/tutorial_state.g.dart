// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutorial_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tutorialControllerHash() =>
    r'bfe30de000adaeaf91239849928b2fbe3f0f45c5';

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

abstract class _$TutorialController extends BuildlessAutoDisposeNotifier<bool> {
  late final TutorialScreen screen;

  bool build(
    TutorialScreen screen,
  );
}

/// See also [TutorialController].
@ProviderFor(TutorialController)
const tutorialControllerProvider = TutorialControllerFamily();

/// See also [TutorialController].
class TutorialControllerFamily extends Family<bool> {
  /// See also [TutorialController].
  const TutorialControllerFamily();

  /// See also [TutorialController].
  TutorialControllerProvider call(
    TutorialScreen screen,
  ) {
    return TutorialControllerProvider(
      screen,
    );
  }

  @override
  TutorialControllerProvider getProviderOverride(
    covariant TutorialControllerProvider provider,
  ) {
    return call(
      provider.screen,
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
  String? get name => r'tutorialControllerProvider';
}

/// See also [TutorialController].
class TutorialControllerProvider
    extends AutoDisposeNotifierProviderImpl<TutorialController, bool> {
  /// See also [TutorialController].
  TutorialControllerProvider(
    TutorialScreen screen,
  ) : this._internal(
          () => TutorialController()..screen = screen,
          from: tutorialControllerProvider,
          name: r'tutorialControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tutorialControllerHash,
          dependencies: TutorialControllerFamily._dependencies,
          allTransitiveDependencies:
              TutorialControllerFamily._allTransitiveDependencies,
          screen: screen,
        );

  TutorialControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.screen,
  }) : super.internal();

  final TutorialScreen screen;

  @override
  bool runNotifierBuild(
    covariant TutorialController notifier,
  ) {
    return notifier.build(
      screen,
    );
  }

  @override
  Override overrideWith(TutorialController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TutorialControllerProvider._internal(
        () => create()..screen = screen,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        screen: screen,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TutorialController, bool> createElement() {
    return _TutorialControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TutorialControllerProvider && other.screen == screen;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, screen.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TutorialControllerRef on AutoDisposeNotifierProviderRef<bool> {
  /// The parameter `screen` of this provider.
  TutorialScreen get screen;
}

class _TutorialControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TutorialController, bool>
    with TutorialControllerRef {
  _TutorialControllerProviderElement(super.provider);

  @override
  TutorialScreen get screen => (origin as TutorialControllerProvider).screen;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

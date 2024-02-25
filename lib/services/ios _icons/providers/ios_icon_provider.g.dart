// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ios_icon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$iosIconHash() => r'149389199464bdb685c1055d0f80f848c7e45a2e';

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

/// See also [iosIcon].
@ProviderFor(iosIcon)
const iosIconProvider = IosIconFamily();

/// See also [iosIcon].
class IosIconFamily extends Family<List<IosIcon>> {
  /// See also [iosIcon].
  const IosIconFamily();

  /// See also [iosIcon].
  IosIconProvider call(
    String qurey,
  ) {
    return IosIconProvider(
      qurey,
    );
  }

  @override
  IosIconProvider getProviderOverride(
    covariant IosIconProvider provider,
  ) {
    return call(
      provider.qurey,
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
  String? get name => r'iosIconProvider';
}

/// See also [iosIcon].
class IosIconProvider extends AutoDisposeProvider<List<IosIcon>> {
  /// See also [iosIcon].
  IosIconProvider(
    String qurey,
  ) : this._internal(
          (ref) => iosIcon(
            ref as IosIconRef,
            qurey,
          ),
          from: iosIconProvider,
          name: r'iosIconProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$iosIconHash,
          dependencies: IosIconFamily._dependencies,
          allTransitiveDependencies: IosIconFamily._allTransitiveDependencies,
          qurey: qurey,
        );

  IosIconProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.qurey,
  }) : super.internal();

  final String qurey;

  @override
  Override overrideWith(
    List<IosIcon> Function(IosIconRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IosIconProvider._internal(
        (ref) => create(ref as IosIconRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        qurey: qurey,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<IosIcon>> createElement() {
    return _IosIconProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IosIconProvider && other.qurey == qurey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, qurey.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IosIconRef on AutoDisposeProviderRef<List<IosIcon>> {
  /// The parameter `qurey` of this provider.
  String get qurey;
}

class _IosIconProviderElement extends AutoDisposeProviderElement<List<IosIcon>>
    with IosIconRef {
  _IosIconProviderElement(super.provider);

  @override
  String get qurey => (origin as IosIconProvider).qurey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

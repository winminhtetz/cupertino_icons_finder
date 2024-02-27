// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ios_icon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$iosIconHash() => r'f8193dd96e16107d65fae73fdd28e4abc51351bf';

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
    String q,
  ) {
    return IosIconProvider(
      q,
    );
  }

  @override
  IosIconProvider getProviderOverride(
    covariant IosIconProvider provider,
  ) {
    return call(
      provider.q,
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
    String q,
  ) : this._internal(
          (ref) => iosIcon(
            ref as IosIconRef,
            q,
          ),
          from: iosIconProvider,
          name: r'iosIconProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$iosIconHash,
          dependencies: IosIconFamily._dependencies,
          allTransitiveDependencies: IosIconFamily._allTransitiveDependencies,
          q: q,
        );

  IosIconProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.q,
  }) : super.internal();

  final String q;

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
        q: q,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<IosIcon>> createElement() {
    return _IosIconProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IosIconProvider && other.q == q;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, q.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IosIconRef on AutoDisposeProviderRef<List<IosIcon>> {
  /// The parameter `q` of this provider.
  String get q;
}

class _IosIconProviderElement extends AutoDisposeProviderElement<List<IosIcon>>
    with IosIconRef {
  _IosIconProviderElement(super.provider);

  @override
  String get q => (origin as IosIconProvider).q;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

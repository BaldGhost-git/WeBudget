// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$budgetByIdHash() => r'a30248d0fb685b159a56de632be33462a4891778';

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

/// See also [budgetById].
@ProviderFor(budgetById)
const budgetByIdProvider = BudgetByIdFamily();

/// See also [budgetById].
class BudgetByIdFamily extends Family<AsyncValue<Budget>> {
  /// See also [budgetById].
  const BudgetByIdFamily();

  /// See also [budgetById].
  BudgetByIdProvider call(int id) {
    return BudgetByIdProvider(id);
  }

  @override
  BudgetByIdProvider getProviderOverride(
    covariant BudgetByIdProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'budgetByIdProvider';
}

/// See also [budgetById].
class BudgetByIdProvider extends AutoDisposeFutureProvider<Budget> {
  /// See also [budgetById].
  BudgetByIdProvider(int id)
    : this._internal(
        (ref) => budgetById(ref as BudgetByIdRef, id),
        from: budgetByIdProvider,
        name: r'budgetByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$budgetByIdHash,
        dependencies: BudgetByIdFamily._dependencies,
        allTransitiveDependencies: BudgetByIdFamily._allTransitiveDependencies,
        id: id,
      );

  BudgetByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<Budget> Function(BudgetByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: BudgetByIdProvider._internal(
        (ref) => create(ref as BudgetByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Budget> createElement() {
    return _BudgetByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BudgetByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BudgetByIdRef on AutoDisposeFutureProviderRef<Budget> {
  /// The parameter `id` of this provider.
  int get id;
}

class _BudgetByIdProviderElement
    extends AutoDisposeFutureProviderElement<Budget>
    with BudgetByIdRef {
  _BudgetByIdProviderElement(super.provider);

  @override
  int get id => (origin as BudgetByIdProvider).id;
}

String _$budgetRepositoryHash() => r'364ff7b0d08d3827ed4430de6b3aa4df0cb90b7b';

/// See also [budgetRepository].
@ProviderFor(budgetRepository)
final budgetRepositoryProvider = AutoDisposeProvider<BudgetRepository>.internal(
  budgetRepository,
  name: r'budgetRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$budgetRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BudgetRepositoryRef = AutoDisposeProviderRef<BudgetRepository>;
String _$budgetListHash() => r'd6c3a5cb05f2f325a863183972f5c296d3005fa8';

/// See also [BudgetList].
@ProviderFor(BudgetList)
final budgetListProvider =
    AutoDisposeAsyncNotifierProvider<BudgetList, List<Budget>?>.internal(
      BudgetList.new,
      name: r'budgetListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$budgetListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BudgetList = AutoDisposeAsyncNotifier<List<Budget>?>;
String _$budgetControllerHash() => r'e697a611ae0789da7a712d79799507258469275d';

/// See also [BudgetController].
@ProviderFor(BudgetController)
final budgetControllerProvider =
    AutoDisposeAsyncNotifierProvider<BudgetController, String?>.internal(
      BudgetController.new,
      name: r'budgetControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$budgetControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BudgetController = AutoDisposeAsyncNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

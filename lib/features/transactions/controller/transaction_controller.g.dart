// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$budgetByIdHash() => r'be05935850366eb0069202abec9b9add32ce8d11';

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
class BudgetByIdFamily extends Family<AsyncValue<Transaction>> {
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
class BudgetByIdProvider extends AutoDisposeFutureProvider<Transaction> {
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
    FutureOr<Transaction> Function(BudgetByIdRef provider) create,
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
  AutoDisposeFutureProviderElement<Transaction> createElement() {
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
mixin BudgetByIdRef on AutoDisposeFutureProviderRef<Transaction> {
  /// The parameter `id` of this provider.
  int get id;
}

class _BudgetByIdProviderElement
    extends AutoDisposeFutureProviderElement<Transaction>
    with BudgetByIdRef {
  _BudgetByIdProviderElement(super.provider);

  @override
  int get id => (origin as BudgetByIdProvider).id;
}

String _$transactionRepositoryHash() =>
    r'c21b8c1d7d2d353876c919af765ee68118e21176';

/// See also [transactionRepository].
@ProviderFor(transactionRepository)
final transactionRepositoryProvider =
    AutoDisposeProvider<TransactionRepository>.internal(
      transactionRepository,
      name: r'transactionRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionRepositoryRef =
    AutoDisposeProviderRef<TransactionRepository>;
String _$transactionListHash() => r'ca66bbfd2eeedd711e382e5fac4574d1775956a4';

/// See also [TransactionList].
@ProviderFor(TransactionList)
final transactionListProvider =
    AutoDisposeAsyncNotifierProvider<
      TransactionList,
      List<Transaction>?
    >.internal(
      TransactionList.new,
      name: r'transactionListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TransactionList = AutoDisposeAsyncNotifier<List<Transaction>?>;
String _$transactionControllerHash() =>
    r'295dae85fd09cab266fe354a0004dbccfaf1d63c';

/// See also [TransactionController].
@ProviderFor(TransactionController)
final transactionControllerProvider =
    AutoDisposeAsyncNotifierProvider<TransactionController, String?>.internal(
      TransactionController.new,
      name: r'transactionControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TransactionController = AutoDisposeAsyncNotifier<String?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

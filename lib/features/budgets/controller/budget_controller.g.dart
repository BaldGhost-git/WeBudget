// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

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
String _$budgetControllerHash() => r'76be55716d394a0ffb8ecad64a51c49c0dd0231f';

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

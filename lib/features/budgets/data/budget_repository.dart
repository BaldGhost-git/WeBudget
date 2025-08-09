import 'package:we_budget/features/budgets/models/budget_model.dart';

abstract class BudgetRepository {
  Future<String?> createBudget(Map<String, dynamic> json);
  Future<String?> deleteBudget(int budgetId);
  Future<String?> updateBudget(Map<String, dynamic> json);
  Future<List<Budget>?> readBudget(int? budgetId);
}

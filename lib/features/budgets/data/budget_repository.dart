import 'package:we_budget/features/budgets/models/budget_model.dart';

abstract class BudgetRepository {
  Future<String?> createBudget(Budget newBudget);
  Future<String?> deleteBudget(int budgetId);
  Future<String?> updateBudget(Budget newBudget);
  Future<List<Budget>?> readBudget(int? budgetId);
}

import 'package:we_budget/features/budgets/models/budget_model.dart';

abstract class BudgetRepository {
  Future<String?> createBudget(Map<String, dynamic> json);
  deleteBudget();
  updateBudget();
  Future<List<Budget>?> readBudget(int? budgetId);
}

import 'package:we_budget/features/budgets/models/budget_model.dart';

abstract class BudgetRepository {
  createBudget();
  deleteBudget();
  updateBudget();
  Future<List<Budget>?> readBudget(int? budgetId);
}

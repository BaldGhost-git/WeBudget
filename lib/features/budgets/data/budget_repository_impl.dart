import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_budget/features/budgets/data/budget_repository.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final SupabaseClient client;

  BudgetRepositoryImpl({required this.client});

  @override
  createBudget() {
    // TODO: implement createBudget
    throw UnimplementedError();
  }

  @override
  deleteBudget() {
    // TODO: implement deleteBudget
    throw UnimplementedError();
  }

  @override
  Future<List<Budget>?> readBudget(int? budgetId) async {
    final query = client.from('Budgets').select();
    if (budgetId != null) {
      query.eq('budget_id', budgetId);
    }
    final data = await query;
    if (data.isEmpty) return null;
    return data.map((e) => Budget.fromJson(e)).toList();
  }

  @override
  updateBudget() {
    // TODO: implement updateBudget
    throw UnimplementedError();
  }
}

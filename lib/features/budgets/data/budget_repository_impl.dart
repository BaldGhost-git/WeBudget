import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_budget/core/clients/supabase.dart';
import 'package:we_budget/features/budgets/data/budget_repository.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final SupabaseClient client;
  final String table = 'Budgets';

  BudgetRepositoryImpl({required this.client});

  @override
  Future<String> createBudget(Map<String, dynamic> json) async {
    await client.from(table).insert(json);
    return "${json["name"].trim()} budget created";
  }

  @override
  Future<List<Budget>?> readBudget(int? budgetId) async {
    final List<Map<String, dynamic>> budgets = await client
        .from(table)
        .select()
        .eq('status', true)
        .maybeEq('budget_id', budgetId);
    if (budgets.isEmpty) return null;
    final List<Budget> data = budgets.map((e) => Budget.fromJson(e)).toList();
    return data;
  }

  @override
  Future<String?> deleteBudget(int budgetId) async {
    await client
        .from(table)
        .update({'status': false})
        .eq('budget_id', budgetId);
    return "Budget deleted";
  }

  @override
  Future<String?> updateBudget(Map<String, dynamic> json) async {
    await client.from(table).update(json).eq('budget_id', json["budget_id"]);
    return "${json["name"].trim()} budget updated";
  }
}

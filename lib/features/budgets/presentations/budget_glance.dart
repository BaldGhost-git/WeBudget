import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:we_budget/core/constants/constants.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';
import 'package:we_budget/features/budgets/presentations/budget_detail.dart';

class BudgetGlance extends StatelessWidget {
  const BudgetGlance(this.budgets, {super.key});

  final List<Budget> budgets;

  List<Budget> get getDailyBudgets =>
      budgets.where((budget) => budget.isDailySpend).toList();
  List<Budget> get getPlannedBudgets =>
      budgets.where((budget) => !budget.isDailySpend).toList();

  List<Widget> displayBudgets(
    BuildContext context,
    List<Budget> budget,
    String title,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Text(title, style: TextStyle(color: Colors.grey.shade500)),
      ),
      ...List.generate(
        budget.length,
        (index) => Card(
          child: InkWell(
            onTap: () =>
                context.push("${BudgetDetail.path}/${budget[index].budgetId}"),
            child: ListTile(
              title: Text(budget[index].name),
              subtitle: Text(budget[index].description ?? ""),
              trailing: Text(
                "Rp. ${Constants.formatThousandFromInt(budget[index].totalAmount)}",
              ),
            ),
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        if (getDailyBudgets.isNotEmpty)
          ...displayBudgets(context, getDailyBudgets, "Daily"),
        if (getPlannedBudgets.isNotEmpty)
          ...displayBudgets(context, getPlannedBudgets, "Planned"),
      ],
    );
  }
}

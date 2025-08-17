import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:we_budget/core/constants/constants.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';
import 'package:we_budget/features/budgets/presentations/budget_detail.dart';

class BudgetGlance extends StatelessWidget {
  const BudgetGlance(this.budgets, {super.key});

  final List<Budget> budgets;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: budgets.length,
      itemBuilder: (context, index) => Card(
        child: InkWell(
          onTap: () =>
              context.push("${BudgetDetail.path}/${budgets[index].budgetId}"),
          child: ListTile(
            title: Text(budgets[index].name),
            subtitle: Text(budgets[index].description ?? ""),
            trailing: Text(
              "Rp. ${Constants.formatThousandFromInt(budgets[index].totalAmount)}",
            ),
          ),
        ),
      ),
    );
  }
}

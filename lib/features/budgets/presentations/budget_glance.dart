import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';
import 'package:we_budget/features/budgets/presentations/budget_detail.dart';

class BudgetGlance extends StatelessWidget {
  const BudgetGlance(this.budgets, {super.key});

  final List<Budget> budgets;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Budgets"), Text("See all")],
        ),
        Gap(12),
        Flexible(
          child: ListView.builder(
            itemCount: budgets.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                child: InkWell(
                  onTap: () => context.push(
                    "${BudgetDetail.path}/${budgets[index].budgetId}",
                  ),
                  child: ListTile(
                    title: Text(budgets[index].name),
                    subtitle: Text(budgets[index].description ?? ""),
                    trailing: Text("Rp. ${budgets[index].totalAmount}"),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

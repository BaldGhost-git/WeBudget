import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:we_budget/core/constants/constants.dart';
import 'package:we_budget/features/budgets/presentations/budget_detail.dart';
import 'package:we_budget/features/transactions/model/transaction_model.dart';

class TransactionGlance extends StatelessWidget {
  const TransactionGlance(this.trx, {super.key});

  final List<Transaction> trx;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Expenses"),
            TextButton(onPressed: () {}, child: Text("See all")),
          ],
        ),
        Gap(12),
        Flexible(
          child: ListView.builder(
            itemCount: trx.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                child: InkWell(
                  // onTap: () => context.push(
                  //   "${BudgetDetail.path}/${trx[index].budgetId}",
                  // ),
                  child: ListTile(
                    title: Text(trx[index].description),
                    subtitle: Text(
                      Constants.dateFormat.format(trx[index].trxDate),
                    ),
                    trailing: Text(
                      "Rp. ${Constants.formatThousandFromInt(trx[index].amount)}",
                    ),
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

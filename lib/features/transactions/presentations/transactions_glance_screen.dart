import 'package:flutter/material.dart';
import 'package:we_budget/core/constants/constants.dart';
import 'package:we_budget/features/transactions/model/transaction_model.dart';

class TransactionGlance extends StatelessWidget {
  const TransactionGlance(this.transactions, {super.key});

  final List<Transaction> transactions;

  List<Transaction> get getCurrentMonthTrx => transactions
      .where((trx) => trx.trxDate.month == DateTime.now().month)
      .toList();
  List<Transaction> get getPreviousMonthTrx => transactions
      .where((trx) => trx.trxDate.month < DateTime.now().month)
      .toList();

  List<Widget> displayTransactions(
    BuildContext context,
    List<Transaction> transactionList,
    String title,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Text(title, style: TextStyle(color: Colors.grey.shade500)),
      ),
      ...List.generate(
        transactionList.length,
        (index) => Card(
          child: InkWell(
            // onTap: () =>
            //     context.push("${BudgetDetail.path}/${transactionList[index].budgetId}"),
            child: ListTile(
              title: Text(transactionList[index].description),
              subtitle: Text(
                Constants.dateFormat.format(transactionList[index].trxDate),
              ),
              trailing: Text(
                "Rp. ${Constants.formatThousandFromInt(transactionList[index].amount)}",
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
        if (getCurrentMonthTrx.isNotEmpty)
          ...displayTransactions(context, getCurrentMonthTrx, "This Month"),
        if (getPreviousMonthTrx.isNotEmpty)
          ...displayTransactions(
            context,
            getPreviousMonthTrx,
            "Previous Month",
          ),
      ],
    );
  }
}

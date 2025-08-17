import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:we_budget/core/constants/constants.dart';
import 'package:we_budget/core/routes/app_route.dart';
import 'package:we_budget/features/budgets/controller/budget_controller.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';
import 'package:we_budget/features/budgets/presentations/upsert_budget_screen.dart';

class BudgetDetail extends ConsumerWidget {
  BudgetDetail({super.key, required this.budgetId});

  static const String path = "/budget";
  final int budgetId;
  final formKey = GlobalKey<FormBuilderState>();

  void updateBudget(WidgetRef ref, BuildContext context, Budget oldBudget) {
    context.goNamed(
      AppRoute.createBudget.name,
      extra: <String, dynamic>{
        'formKey': formKey,
        'onSubmit': () {
          if (formKey.currentState?.saveAndValidate() ?? false) {
            var {
              'start_date': startDate,
              'name': name,
              'total_amount': totalAmount,
              'reset_days': resetDays,
            } = formKey.currentState!.value;
            final newBudget = oldBudget.copyWith(
              startDate: startDate as DateTime,
              name: name as String,
              totalAmount: int.parse(totalAmount as String),
              modifiedAt: DateTime.now(),
              resetDay: resetDays as int?,
            );
            ref.read(budgetControllerProvider.notifier).updateBudget(newBudget);
            context.pop();
          }
        },
        'budget': oldBudget,
      },
    );
  }

  _showDeleteDialog(BuildContext context, WidgetRef ref) async {
    final isDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Budget'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Delete this budget? This budget will be lost forever.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              context.pop(true);
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              context.pop(false);
            },
          ),
        ],
      ),
    );

    if (isDelete) {
      ref.read(budgetControllerProvider.notifier).deleteBudget(budgetId);
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budget = ref.watch(budgetByIdProvider(budgetId));
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget"),
        actions: [
          IconButton(
            onPressed: () => _showDeleteDialog(context, ref),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: budget.whenOrNull(
        data: (data) => Column(
          children: [
            Text("This is your ${data.name} budget"),
            Text("Your total budget is Rp. ${data.totalAmount}"),
            Text("Your remaining budget is Rp. xxxx"),
            Text("${data.daysBeforeReset} days left before budget resets"),
            Text(
              "Your budget will resetted in ${Constants.dateFormat.format(data.resetDate)}",
            ),
            FilledButton(
              onPressed: () => updateBudget(ref, context, data),
              child: Text("Update"),
            ),
          ],
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text(err.toString())),
      ),
    );
  }
}

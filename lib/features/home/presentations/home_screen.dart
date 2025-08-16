import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:we_budget/core/constants/constants.dart';
import 'package:we_budget/core/routes/app_route.dart';
import 'package:we_budget/core/widgets/custom_snack_bar.dart';
import 'package:we_budget/features/budgets/controller/budget_controller.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';
import 'package:we_budget/features/budgets/presentations/budget_glance.dart';
import 'package:we_budget/features/budgets/presentations/widgets/add_budget_bottom_sheet.dart';
import 'package:we_budget/features/home/controller/home_controller.dart';
import 'package:we_budget/features/transactions/presentations/transactions_glance_screen.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  static const String path = "/home";
  final formKey = GlobalKey<FormBuilderState>();

  Future<void> createBudget(WidgetRef ref, BuildContext context) async {
    await showModalBottomSheet<Budget?>(
      context: context,
      builder: (context) => AddBudgetBottomSheet(
        formKey,
        onSubmit: () {
          if (formKey.currentState?.saveAndValidate() ?? false) {
            var {
              'start_date': startDate,
              'name': name,
              'total_amount': totalAmount,
              'reset_days': resetDays,
            } = formKey.currentState!.value;
            final budgetItem = Budget(
              startDate: startDate as DateTime,
              name: name as String,
              totalAmount: int.parse(totalAmount as String),
              createdAt: DateTime.now(),
              resetDay: int.tryParse(resetDays as String),
            );
            ref
                .read(budgetControllerProvider.notifier)
                .createBudget(budgetItem);
            context.pop();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final record = ref.watch(homeRecordProvider);
    final theme = Theme.of(context);
    ref.listen(budgetControllerProvider, (prev, next) {
      next.whenOrNull(
        data: (msg) {
          if (msg?.isNotEmpty ?? false) {
            CustomSnackBar.show(
              context,
              CustomSnackBarMode.success,
              msg ?? "Successs",
              durationInSeconds: 2,
            );
          }
        },
        error: (err, st) => CustomSnackBar.show(
          context,
          CustomSnackBarMode.error,
          err.toString(),
          durationInSeconds: 2,
        ),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('My Budget'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(AppRoute.settings.name),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
            child: record.when(
              data: (data) {
                if (data.$1?.isEmpty ?? true) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRect(
                        clipBehavior: Clip.hardEdge,
                        child: Transform.scale(
                          alignment: AlignmentGeometry.xy(-1, -1.2),
                          scale: 1.9,
                          child: Image.asset('lib/assets/piggy-bank.png'),
                        ),
                      ),
                      Text(
                        "Oops! Looks like you don't have any budget",
                        style: theme.textTheme.titleLarge,
                      ),
                      Gap(12),
                      FilledButton.icon(
                        onPressed: () => createBudget(ref, context),
                        icon: Icon(Icons.add),
                        label: Text("Add new budget here!"),
                      ),
                    ],
                  );
                }
                return Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hi There!'),
                        Text(
                          'Today, you can spend a total of',
                          style: theme.textTheme.bodyLarge,
                        ),
                        Text(
                          'Rp. ${Constants.formatThousandFromInt(1000000)}',
                          style: theme.textTheme.displayMedium,
                        ),
                        Gap(12),
                        Flexible(
                          child: PageView(
                            onPageChanged: (value) =>
                                ref.read(pageProvider.notifier).state = value,
                            children: [
                              BudgetGlance(data.$1!),
                              data.$2?.isEmpty ?? true
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            ClipRect(
                                              clipBehavior: Clip.hardEdge,
                                              child: Transform.scale(
                                                scale: 2.1,
                                                alignment: AlignmentGeometry.xy(
                                                  -1.0,
                                                  0.7,
                                                ),
                                                child: Image.asset(
                                                  fit: BoxFit.cover,
                                                  'lib/assets/piggy-bank.png',
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Oh? No transactions? Let's save that money!",
                                              style: theme.textTheme.titleLarge,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : TransactionGlance(data.$2!),
                              // TransactionGlance(data.$2!),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Consumer(
                          builder: (context, ref, child) {
                            final page = ref.watch(pageProvider);
                            return FloatingActionButton(
                              child: Icon(Icons.add),
                              onPressed: () => page == 0
                                  ? createBudget(ref, context)
                                  : context.pushNamed(
                                      AppRoute.createTransactions.name,
                                    ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (error, st) => Text("Error happen, $error"),
              loading: () => CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}

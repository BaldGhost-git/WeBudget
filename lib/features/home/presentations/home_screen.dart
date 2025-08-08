import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:we_budget/core/widgets/custom_snack_bar.dart';
import 'package:we_budget/features/auth/controllers/auth_controller.dart';
import 'package:we_budget/features/budgets/controller/budget_controller.dart';
import 'package:we_budget/features/budgets/presentations/budget_screen.dart';
import 'package:we_budget/features/budgets/presentations/widgets/add_budget_bottom_sheet.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const String path = "/home";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgets = ref.watch(budgetListProvider);
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
            onPressed: ref.read(authControllerProvider.notifier).signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: budgets.when(
            data: (data) {
              if (data?.isEmpty ?? true) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRect(
                      clipBehavior: Clip.hardEdge,
                      child: Align(
                        alignment: Alignment.topLeft,
                        heightFactor: 0.5,
                        widthFactor: 0.55,
                        child: Image.asset('lib/assets/piggy-bank.png'),
                      ),
                    ),
                    Text(
                      "Oops! Looks like you don't have any budget",
                      style: theme.textTheme.titleLarge,
                    ),
                    Gap(12),
                    FilledButton.icon(
                      onPressed: () async {
                        final budgetItem = await showModalBottomSheet(
                          context: context,
                          builder: (context) => AddBudgetBottomSheet(),
                        );
                        ref
                            .read(budgetControllerProvider.notifier)
                            .createBudget(budgetItem);
                      },
                      icon: Icon(Icons.add),
                      label: Text("Add new budget here!"),
                    ),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hi There!'),
                  Text(
                    'Today, you can spend a total of',
                    style: theme.textTheme.bodyLarge,
                  ),
                  Text("Rp. 1.000.000", style: theme.textTheme.displayMedium),
                  Gap(12),
                  Flexible(
                    child: PageView(
                      children: [
                        BudgetGlance(data!),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Placeholder(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            error: (error, StackTrace) => Text("Error happen, $error"),
            loading: () => CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

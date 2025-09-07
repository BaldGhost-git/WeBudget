import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:we_budget/core/widgets/custom_input_decorator.dart';
import 'package:we_budget/core/widgets/custom_snack_bar.dart';
import 'package:we_budget/features/budgets/controller/budget_controller.dart';
import 'package:we_budget/features/transactions/controller/amount_text.dart';
import 'package:we_budget/features/transactions/controller/transaction_controller.dart';
import 'package:we_budget/features/transactions/widgets/calculator_pads.dart';

class CreateTransactionScreen extends ConsumerStatefulWidget {
  const CreateTransactionScreen({super.key});

  static const String path = '/new';

  @override
  ConsumerState<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState
    extends ConsumerState<CreateTransactionScreen> {
  // final formKey = GlobalKey<FormBuilderState>();
  final AmountText calculatePriceText = AmountText();

  @override
  Widget build(BuildContext context) {
    ref.listen(transactionControllerProvider, (prev, next) {
      next.whenOrNull(
        data: (msg) {
          if (msg?.isNotEmpty ?? false) {
            CustomSnackBar.show(
              context,
              CustomSnackBarMode.success,
              msg!,
              durationInSeconds: 2,
            );
            context.pop();
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("New Transactions"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
      ),
      body: SafeArea(
        bottom: true,
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final topContainerHeight = constraints.maxHeight * 0.4;
            return Stack(
              children: [
                Container(height: topContainerHeight, color: Colors.grey[300]),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (constraints.maxWidth * 0.05) / 2,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: topContainerHeight,
                        child: Column(
                          children: [
                            Gap(constraints.maxHeight * 0.12),
                            Consumer(
                              builder: (context, ref, child) {
                                final data = ref.watch(budgetListProvider);
                                return data.when(
                                  data: (budgets) {
                                    if (budgets?.isEmpty ?? true) {
                                      return Center(
                                        child: FormBuilderTextField(
                                          name: 'budget_id',
                                          enabled: false,
                                          decoration: customInputDecoration(
                                            labelText: "Budget",
                                            hintText:
                                                "You don't have any budget",
                                          ),
                                        ),
                                      );
                                    }
                                    return Center(
                                      child: SizedBox(
                                        width: constraints.maxWidth * 0.6,
                                        child: FormBuilderDropdown(
                                          name: 'budget_id',
                                          items: budgets!
                                              .map(
                                                (budget) => DropdownMenuItem(
                                                  value: budget.budgetId,
                                                  child: Text(budget.name),
                                                ),
                                              )
                                              .toList(),
                                          decoration: customInputDecoration(
                                            labelText: "Budget",
                                            hintText: "Select your budget",
                                          ),
                                          validator:
                                              FormBuilderValidators.required(
                                                errorText: "Budget is required",
                                              ),
                                        ),
                                      ),
                                    );
                                  },
                                  error: (err, st) => Text(err.toString()),
                                  loading: () => FormBuilderTextField(
                                    enabled: false,
                                    name: 'budget_id',
                                    decoration: customInputDecoration(
                                      labelText: "Budget",
                                    ),
                                  ),
                                );
                              },
                            ),
                            Gap(24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    child: ListenableBuilder(
                                      listenable: calculatePriceText,
                                      builder:
                                          (
                                            BuildContext context,
                                            Widget? child,
                                          ) => Text(
                                            calculatePriceText.amount,
                                            style: TextStyle(fontSize: 80),
                                          ),
                                    ),
                                  ),
                                ),
                                Gap(12),
                                Text("IDR", style: TextStyle(fontSize: 48)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gap(6),
                      Expanded(
                        child: CalculatorPads(controller: calculatePriceText),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

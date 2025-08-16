import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:we_budget/core/constants/constants.dart';
import 'package:we_budget/core/widgets/custom_input_decorator.dart';
import 'package:we_budget/core/widgets/custom_snack_bar.dart';
import 'package:we_budget/features/budgets/controller/budget_controller.dart';
import 'package:we_budget/features/transactions/controller/transaction_controller.dart';

class CreateTransactionScreen extends ConsumerWidget {
  CreateTransactionScreen({super.key});

  static const String path = '/new';

  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionControllerState = ref.watch(transactionControllerProvider);
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
      appBar: AppBar(title: Text("New Transaction")),
      body: FormBuilder(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'amount',
                inputFormatters: [ThousandsSeparatorInputFormatter()],
                keyboardType: TextInputType.number,
                maxLines: 1,
                decoration: customInputDecoration(
                  labelText: "Transaction Amount",
                  hintText: "12.000?",
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: "Amount is required",
                  ),
                  FormBuilderValidators.numeric(errorText: "Amount is invalid"),
                  FormBuilderValidators.positiveNumber(
                    errorText: "Amount is invalid",
                  ),
                ]),
              ),
              const Gap(12),
              FormBuilderTextField(
                name: 'description',
                keyboardType: TextInputType.text,
                maxLines: 1,
                decoration: customInputDecoration(
                  labelText: "Description",
                  hintText: "Makan warteg",
                ),
              ),
              const Gap(12),
              FormBuilderDateTimePicker(
                inputType: InputType.date,
                name: 'trx_date',
                format: Constants.dateFormat,
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime.now(),
                initialValue: DateTime.now(),
                initialDate: DateTime.now(),
                decoration: customInputDecoration(
                  labelText: "Transaction Date",
                  hintText: "1 April 2025",
                ),
              ),
              const Gap(12),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final data = ref.watch(budgetListProvider);
                  return data.when(
                    data: (budgets) {
                      if (budgets?.isEmpty ?? true) {
                        return FormBuilderTextField(
                          name: 'budget_id',
                          enabled: false,
                          decoration: customInputDecoration(
                            labelText: "Budget",
                            hintText: "You don't have any budget",
                          ),
                        );
                      }
                      return FormBuilderDropdown(
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
                        validator: FormBuilderValidators.required(
                          errorText: "Budget is required",
                        ),
                      );
                    },
                    error: (err, st) => Text(err.toString()),
                    loading: () => FormBuilderTextField(
                      enabled: false,
                      name: 'budget_id',
                      decoration: customInputDecoration(labelText: "Budget"),
                    ),
                  );
                },
              ),
              const Gap(12),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                    SizedBox(
                      width: 200,
                      child: ElevatedButton.icon(
                        onPressed: !transactionControllerState.isLoading
                            ? () {
                                if (formKey.currentState!.saveAndValidate()) {
                                  final formValue = formKey.currentState!.value;
                                  ref
                                      .read(
                                        transactionControllerProvider.notifier,
                                      )
                                      .createTransaction(formValue);
                                }
                              }
                            : () {},
                        label: transactionControllerState.isLoading
                            ? CircularProgressIndicator()
                            : Text("Add transaction"),
                        icon: Icon(Icons.attach_money_rounded),
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:we_budget/core/constants/constants.dart';
import 'package:we_budget/core/widgets/custom_input_decorator.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';

class AddBudgetBottomSheet extends StatefulWidget {
  const AddBudgetBottomSheet(
    this.formKey, {
    super.key,
    required this.onSubmit,
    this.budget,
  });

  final GlobalKey<FormBuilderState> formKey;
  final void Function()? onSubmit;
  final Budget? budget;

  @override
  State<AddBudgetBottomSheet> createState() => _AddBudgetBottomSheetState();
}

class _AddBudgetBottomSheetState extends State<AddBudgetBottomSheet> {
  late final TextEditingController budgetStartDateController;
  final double horizontalDimens = 5;
  final double verticalDimens = 5;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    budgetStartDateController = TextEditingController();
  }

  @override
  void dispose() {
    budgetStartDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final initialDate =
        _selectedDate ?? widget.budget?.startDate ?? DateTime.now();
    final formState = widget.formKey.currentState;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalDimens + 10,
        vertical: verticalDimens,
      ),
      child: FormBuilder(
        autovalidateMode: AutovalidateMode.onUnfocus,
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('New Budget', style: theme.textTheme.titleLarge),
                FilledButton.icon(
                  onPressed: widget.onSubmit,
                  label: widget.budget == null
                      ? const Text('Add')
                      : const Text('Update'),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const Gap(8),
            FormBuilderTextField(
              name: 'name',
              validator: FormBuilderValidators.required(
                errorText: "Insert your budget name",
              ),
              initialValue: widget.budget?.name,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: customInputDecoration(
                labelText: 'Budget Name',
                hintText: 'Food',
              ),
            ),
            const Gap(12),
            FormBuilderTextField(
              name: 'total_amount',
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: "Insert your budget amount",
                ),
                FormBuilderValidators.numeric(
                  errorText: "Insert the correct amount",
                ),
              ]),
              initialValue: widget.budget?.totalAmount.toString(),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [ThousandsSeparatorInputFormatter()],
              decoration: customInputDecoration(
                labelText: 'Budget Amount',
                hintText: '500.000',
              ),
            ),
            const Gap(12),
            FormBuilderDateTimePicker(
              initialValue: initialDate,
              inputType: InputType.date,
              format: Constants.dateFormat,
              name: 'start_date',
              firstDate: DateTime(2000),
              lastDate: DateTime(2040),
              decoration: customInputDecoration(labelText: 'Start Date'),
            ),
            const Gap(12),
            FormBuilderTextField(
              name: 'reset_days',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              initialValue: widget.budget?.resetDay.toString(),
              decoration: customInputDecoration(
                labelText: 'Reset Days',
                hintText: '30',
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(
                  errorText: "Insert the number of days to reset",
                ),
                FormBuilderValidators.numeric(
                  errorText: "Insert the valid number of days",
                ),
              ]),
            ),
            const Gap(12),
            if (formState?.instantValue["start_date"] != null &&
                formState?.instantValue["reset_days"] != null) ...[
              Text("Your budget will be resetted in"),
              Text(
                Constants.dateFormat.format(
                  (formState?.instantValue["start_date"] as DateTime).add(
                    Duration(
                      days: int.parse(
                        formState?.instantValue["reset_days"] as String,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

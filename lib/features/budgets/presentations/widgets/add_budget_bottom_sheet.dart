import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
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
  final DateFormat dateFormat = DateFormat('dd MMM y');

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
                  onPressed: formState?.validate() ?? false
                      ? widget.onSubmit
                      : null,
                  label: const Text('Add'),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const Gap(8),
            FormBuilderTextField(
              name: 'name',
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return "Insert your budget name";
                }
                return null;
              },
              initialValue: widget.budget?.name,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Budget Name',
                hintText: 'Food',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(12),
            FormBuilderTextField(
              name: 'total_amount',
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return "Insert your budget amount";
                }
                if (int.tryParse(value!) == null || int.tryParse(value)! <= 0) {
                  return "Insert the correct amount";
                }
                return null;
              },
              initialValue: widget.budget?.totalAmount.toString(),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Budget Amount',
                hintText: 'Rp. 500000',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(12),
            FormBuilderDateTimePicker(
              initialValue: initialDate,
              inputType: InputType.date,
              format: dateFormat,
              name: 'start_date',
              firstDate: DateTime(2000),
              lastDate: DateTime(2040),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Start Date',
                border: OutlineInputBorder(),
              ),
            ),
            const Gap(12),
            FormBuilderTextField(
              name: 'reset_days',
              initialValue: widget.budget?.resetDay.toString(),
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Reset Days',
                hintText: '30',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return "Insert the number of days to reset";
                }
                if (int.tryParse(value!) == null || int.tryParse(value)! <= 0) {
                  return "Insert the valid number of days";
                }
                return null;
              },
            ),
            const Gap(12),
            if (formState?.instantValue["start_date"] != null &&
                formState?.instantValue["reset_days"] != null) ...[
              Text("Your budget will be resetted in"),
              Text(
                dateFormat.format(
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

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';

class AddBudgetBottomSheet extends StatefulWidget {
  const AddBudgetBottomSheet({super.key});

  @override
  State<AddBudgetBottomSheet> createState() => _AddBudgetBottomSheetState();
}

class _AddBudgetBottomSheetState extends State<AddBudgetBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController budgetNameController;
  late final TextEditingController budgetAmountController;
  late final TextEditingController budgetStartDateController;
  late final TextEditingController budgetResetDayController;
  final double horizontalDimens = 5;
  final double verticalDimens = 5;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    budgetNameController = TextEditingController();
    budgetAmountController = TextEditingController();
    budgetStartDateController = TextEditingController();
    budgetResetDayController = TextEditingController();
  }

  @override
  void dispose() {
    budgetNameController.dispose();
    budgetAmountController.dispose();
    budgetStartDateController.dispose();
    budgetResetDayController.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      budgetStartDateController
        ..text = DateFormat('dd MMMM y').format(_selectedDate!)
        ..selection = TextSelection.fromPosition(
          TextPosition(
            offset: budgetStartDateController.text.length,
            affinity: TextAffinity.upstream,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalDimens + 10,
        vertical: verticalDimens,
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('New Budget', style: theme.textTheme.titleLarge),
                FilledButton.icon(
                  onPressed: () {
                    _formKey.currentState?.save();
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.of(context).pop(
                        Budget(
                          name: budgetNameController.text,
                          startDate: _selectedDate ?? DateTime.now(),
                          totalAmount: int.parse(budgetAmountController.text),
                          createdAt: DateTime.now(),
                        ),
                      );
                    }
                  },
                  label: const Text('Add'),
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const Gap(8),
            TextFormField(
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return "Insert your budget name";
                }
                return null;
              },
              controller: budgetNameController,
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
            TextFormField(
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return "Insert your budget amount";
                }
                if (int.tryParse(value!) == null || int.tryParse(value)! <= 0) {
                  return "Insert the correct amount";
                }
                return null;
              },
              controller: budgetAmountController,
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
            TextFormField(
              canRequestFocus: false,
              controller: budgetStartDateController,
              onTap: () {
                _selectDate(context);
              },
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Start Date',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

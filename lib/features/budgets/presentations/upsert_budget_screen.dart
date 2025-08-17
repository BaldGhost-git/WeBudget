import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:we_budget/core/constants/constants.dart';
import 'package:we_budget/core/widgets/custom_input_decorator.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';

class UpsertBudgetScreen extends StatefulWidget {
  const UpsertBudgetScreen(
    this.formKey, {
    super.key,
    required this.onSubmit,
    this.budget,
  });

  final GlobalKey<FormBuilderState> formKey;
  final void Function()? onSubmit;
  final Budget? budget;
  static const String path = '/budget';

  @override
  State<UpsertBudgetScreen> createState() => _UpsertBudgetScreenState();
}

class _UpsertBudgetScreenState extends State<UpsertBudgetScreen> {
  late final TextEditingController budgetStartDateController;
  final double horizontalDimens = 5;
  final double verticalDimens = 5;
  late DateTime? _selectedDate;
  late bool isDailySpend;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.budget?.startDate ?? DateTime.now();
    isDailySpend = widget.budget?.isDailySpend ?? false;
    budgetStartDateController = TextEditingController();
  }

  @override
  void dispose() {
    budgetStartDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = widget.formKey.currentState;
    final appTitle = widget.budget != null ? "Update Budget" : "New Budget";

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
        leading: IconButton(onPressed: context.pop, icon: Icon(Icons.close)),
        centerTitle: true,
        actions: [
          IconButton(onPressed: widget.onSubmit, icon: const Icon(Icons.check)),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalDimens + 10,
          vertical: verticalDimens,
        ),
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.onUnfocus,
          key: widget.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FormBuilderTextField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                const Gap(16),
                FormBuilderTextField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                  // inputFormatters: [ThousandsSeparatorInputFormatter()],
                  decoration: customInputDecoration(
                    labelText: 'Budget Amount',
                    hintText: '500.000',
                  ),
                ),
                const Gap(16),
                FormBuilderTextField(
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                const Gap(16),
                FormBuilderDateTimePicker(
                  initialValue: _selectedDate,
                  inputType: InputType.date,
                  format: Constants.dateFormat,
                  name: 'start_date',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2040),
                  decoration: customInputDecoration(labelText: 'Start Date'),
                ),
                const Gap(16),
                FormBuilderField<bool>(
                  name: "is_daily_spend",
                  initialValue: isDailySpend,
                  builder: (FormFieldState<dynamic> field) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text("Include in daily spending?"),
                    trailing: Switch(
                      value: isDailySpend,
                      onChanged: (value) =>
                          setState(() => isDailySpend = value),
                    ),
                  ),
                ),
                const Gap(16),
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
        ),
      ),
    );
  }
}

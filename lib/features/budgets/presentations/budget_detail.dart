import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:we_budget/core/constants/constants.dart';
import 'package:we_budget/core/routes/app_route.dart';
import 'package:we_budget/features/budgets/controller/budget_controller.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class BudgetDetail extends ConsumerStatefulWidget {
  const BudgetDetail({super.key, required this.budgetId});

  static const String path = "/budget";
  final int budgetId;

  @override
  ConsumerState<BudgetDetail> createState() => _BudgetDetailState();
}

class _BudgetDetailState extends ConsumerState<BudgetDetail> {
  final formKey = GlobalKey<FormBuilderState>();
  SampleItem? selectedMenu;

  List<Widget> getMenuChildren(AsyncValue<Budget> budget) {
    return [
      MenuItemButton(onPressed: () {}, child: Text('Invite Others')),
      MenuItemButton(
        onPressed: () {
          if (!budget.isLoading && budget.hasValue) {
            updateBudget(ref, context, budget.value!);
          }
        },
        child: Text('Update Budget'),
      ),
      MenuItemButton(
        onPressed: () => _showDeleteDialog(context, ref),
        child: Text("Delete Budget", style: TextStyle(color: Colors.red)),
      ),
    ];
  }

  void updateBudget(WidgetRef ref, BuildContext context, Budget oldBudget) {
    context.pushNamed(
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
              'is_daily_spend': isDailySpend,
            } = formKey.currentState!.value;
            final newBudget = oldBudget.copyWith(
              startDate: startDate as DateTime,
              name: name as String,
              totalAmount: int.parse(totalAmount as String),
              modifiedAt: DateTime.now(),
              resetDay: resetDays as int?,
              isDailySpend: isDailySpend as bool,
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
      ref.read(budgetControllerProvider.notifier).deleteBudget(widget.budgetId);
      if (context.mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final budget = ref.watch(budgetByIdProvider(widget.budgetId));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Budget Detail"),
        centerTitle: true,
        actions: [
          MenuAnchor(
            builder: (context, controller, child) => IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: Icon(Icons.more_horiz),
            ),
            menuChildren: getMenuChildren(budget),
          ),
        ],
      ),
      body: budget.whenOrNull(
        data: (data) => SafeArea(
          top: false,
          bottom: true,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final topContainerHeight = constraints.maxHeight * 0.4;
              return Stack(
                children: [
                  Container(
                    height: topContainerHeight,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: (constraints.maxWidth * 0.05) / 2,
                    ),
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                            height: topContainerHeight,
                            child: Column(
                              children: [
                                Gap(constraints.maxHeight * 0.11),
                                CircleAvatar(radius: 50),
                                Text(data.name, style: TextStyle(fontSize: 24)),
                                if (data.description?.isNotEmpty ?? false)
                                  Text(
                                    data.description!,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                FittedBox(
                                  child: Text(
                                    "Rp. 50.000 / Rp. ${Constants.formatThousandFromInt(data.totalAmount)}",
                                    style: TextStyle(fontSize: 24),
                                  ),
                                ),
                                Gap(15),
                                Text(
                                  "${data.daysBeforeReset} days left before resets",
                                ),
                                Text(
                                  Constants.dateFormat.format(data.resetDate),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text(err.toString())),
      ),
    );
  }
}

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
import 'package:we_budget/features/home/controller/home_controller.dart';
import 'package:we_budget/features/home/presentations/home_page_view.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  static const String path = "/home";
  final formKey = GlobalKey<FormBuilderState>();

  void createBudget(WidgetRef ref, BuildContext context) {
    context.pushNamed(
      AppRoute.createBudget.name,
      extra: <String, dynamic>{
        'formKey': formKey,
        'onSubmit': () {
          if (formKey.currentState?.saveAndValidate() ?? false) {
            var {
              'start_date': startDate,
              'name': name,
              'description': description,
              'total_amount': totalAmount,
              'reset_days': resetDays,
              'is_daily_spend': isDailySpend,
            } = formKey.currentState!.value;
            final budgetItem = Budget(
              startDate: startDate as DateTime,
              name: name as String,
              description: description as String?,
              totalAmount: double.parse(totalAmount as String),
              createdAt: DateTime.now(),
              resetDay: int.tryParse(resetDays as String),
              isDailySpend: isDailySpend as bool,
            );
            ref
                .read(budgetControllerProvider.notifier)
                .createBudget(budgetItem);
            context.pop();
          }
        },
      },
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('WeBudget'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(AppRoute.settings.name),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: record.when(
        data: (data) {
          if (data.$1?.isEmpty ?? true) {
            return EmptyBudget(theme, ref);
          }
          return SafeArea(
            bottom: true,
            top: false,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final topContainerHeight = constraints.maxHeight * 0.26;
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
                          SizedBox(
                            height: topContainerHeight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Gap(constraints.maxHeight * 0.10),
                                Text('Hi There!'),
                                Text(
                                  'Today, you can spend a total of',
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Text(
                                  'Rp. ${Constants.formatThousandFromInt(1000000)}',
                                  style: theme.textTheme.displayMedium,
                                ),
                              ],
                            ),
                          ),
                          Gap(10),
                          Expanded(child: HomePageView(data)),
                        ],
                      ),
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
            ),
          );
        },
        error: (error, st) => Text("Error happen, $error"),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget EmptyBudget(ThemeData theme, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: (constraints.maxWidth * 0.05) / 2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: constraints.maxHeight * 0.35,
              child: ClipRect(
                clipBehavior: Clip.hardEdge,
                child: Transform.scale(
                  alignment: AlignmentGeometry.xy(-1, -1.2),
                  scale: 1.9,
                  child: Image.asset('lib/assets/piggy-bank.png'),
                ),
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
        ),
      ),
    );
  }
}

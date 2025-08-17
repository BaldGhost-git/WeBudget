import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_budget/core/widgets/tab_stadium_indicator.dart';
import 'package:we_budget/features/budgets/controller/budget_controller.dart';
import 'package:we_budget/features/budgets/models/budget_model.dart';
import 'package:we_budget/features/budgets/presentations/budget_glance.dart';
import 'package:we_budget/features/transactions/model/transaction_model.dart';
import 'package:we_budget/features/transactions/presentations/transactions_glance_screen.dart';

class HomePageView extends ConsumerStatefulWidget {
  const HomePageView(this.data, {super.key});

  final (List<Budget>?, List<Transaction>?) data;

  @override
  ConsumerState<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref.read(pageProvider.notifier).state = _tabController.index;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TabBar(
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          dividerColor: Colors.transparent,
          unselectedLabelColor: Colors.grey.shade500,
          indicator: StadiumTabIndicator(
            color: Colors.grey.shade300,
            verticalPadding: 6,
            horizontalPadding: 16,
          ),
          onTap: (value) => ref.read(pageProvider.notifier).state = value,
          controller: _tabController,
          tabs: [
            Tab(child: Text("Budget")),
            Tab(child: Text("Transactions")),
          ],
        ),
        Flexible(
          child: TabBarView(
            controller: _tabController,
            children: [
              BudgetGlance(widget.data.$1!),
              widget.data.$2?.isEmpty ?? true
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          children: [
                            ClipRect(
                              clipBehavior: Clip.hardEdge,
                              child: Transform.scale(
                                scale: 2.1,
                                alignment: AlignmentGeometry.xy(-1.0, 0.7),
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
                  : TransactionGlance(widget.data.$2!),
            ],
          ),
        ),
      ],
    );
  }
}

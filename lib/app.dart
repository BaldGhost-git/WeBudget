import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_budget/core/routes/app_route.dart';

class WeBudgetApp extends ConsumerWidget {
  const WeBudgetApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(getRoutesProvider),
    );
  }
}

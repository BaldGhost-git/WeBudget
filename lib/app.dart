import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_budget/core/routes/app_route.dart';

class WeBudgetApp extends ConsumerWidget {
  const WeBudgetApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepOrangeAccent,
        inputDecorationTheme: inputDecorationTheme.copyWith(
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),
      routerConfig: ref.watch(getRoutesProvider),
    );
  }
}

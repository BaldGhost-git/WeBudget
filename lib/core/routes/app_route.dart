import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_budget/features/auth/controllers/auth_controller.dart';
import 'package:we_budget/features/auth/presentations/login_screen.dart';
import 'package:we_budget/features/home/presentations/home_screen.dart';

part 'app_route.g.dart';

enum AppRoute { auth, home, transactions }

@Riverpod(keepAlive: true)
GoRouter getRoutes(Ref ref) {
  final user = ref.watch(authControllerProvider);
  return GoRouter(
    initialLocation: user == null ? AuthScreen.path : HomeScreen.path,
    routes: [
      GoRoute(
        name: AppRoute.auth.name,
        path: AuthScreen.path,
        builder: (context, state) => AuthScreen(),
      ),
      GoRoute(
        path: HomeScreen.path,
        name: AppRoute.home.name,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}

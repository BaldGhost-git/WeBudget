import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:we_budget/core/clients/supabase.dart';
import 'package:we_budget/features/auth/controllers/auth_controller.dart';
import 'package:we_budget/features/auth/data/user_repository.dart';
import 'package:we_budget/features/auth/data/user_repository_impl.dart';
import 'package:we_budget/features/auth/models/user_model.dart';

part 'user_controller.g.dart';

@Riverpod(keepAlive: true)
class UserController extends _$UserController {
  @override
  Future<AppUser?> build() async {
    final user = ref.watch(authControllerProvider);
    if (user == null) return null;
    return getUser(user.email!);
  }

  Future<AppUser?> getUser(String email) async {
    final userRepository = ref.read(userRepositoryProvider);
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() => userRepository.getUser(email));
    return userRepository.getUser(email);
  }
}

@riverpod
UserRepository userRepository(Ref ref) {
  final client = ref.watch(supabaseInstanceProvider);
  return UserRepositoryImpl(client: client);
}

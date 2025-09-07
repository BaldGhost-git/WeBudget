import 'package:we_budget/features/auth/models/user_model.dart';

abstract class UserRepository {
  Future<AppUser?> getUser(String email);
}

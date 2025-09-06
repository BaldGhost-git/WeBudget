import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:we_budget/features/auth/data/user_repository.dart';
import 'package:we_budget/features/auth/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final SupabaseClient client;

  UserRepositoryImpl({required this.client});

  @override
  Future<AppUser?> getUser(String email) async {
    final row = await client.from('Users').select();
    if (row.isEmpty) return null;
    return AppUser.fromJson(row[0]);
  }
}

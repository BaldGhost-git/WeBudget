import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'supabase.g.dart';

@Riverpod(keepAlive: true)
SupabaseClient supabaseInstance(Ref ref) {
  return Supabase.instance.client;
}

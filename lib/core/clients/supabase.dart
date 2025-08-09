import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'supabase.g.dart';

@Riverpod(keepAlive: true)
SupabaseClient supabaseInstance(Ref ref) {
  return Supabase.instance.client;
}

extension ConditionalFilter on PostgrestFilterBuilder {
  PostgrestFilterBuilder maybeEq(String column, dynamic value) {
    if (value != null) {
      return eq(column, value);
    }
    return this;
  }
}

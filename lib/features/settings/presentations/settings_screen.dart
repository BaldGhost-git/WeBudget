import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:we_budget/features/auth/controllers/auth_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const String path = "/setting";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          ListTile(title: Text("Currency"), trailing: Text("Rp")),
          Consumer(
            builder: (cotext, ref, child) => ListTile(
              title: Text("Log out"),
              trailing: Icon(Icons.logout_rounded),
              onTap: ref.read(authControllerProvider.notifier).signOut,
            ),
          ),
        ],
      ),
    );
  }
}

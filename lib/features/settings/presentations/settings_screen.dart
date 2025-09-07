import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:we_budget/features/auth/controllers/auth_controller.dart';
import 'package:we_budget/features/auth/controllers/user_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const String path = "/setting";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userControllerProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        bottom: true,
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final topContainerHeight = constraints.maxHeight * 0.32;
            return Stack(
              children: [
                Container(
                  height: topContainerHeight,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (constraints.maxWidth * 0.05) / 2,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: topContainerHeight,
                        child: Center(
                          child: Column(
                            children: [
                              Gap(constraints.maxHeight * 0.11),
                              CircleAvatar(radius: 50),
                              Gap(12),
                              Text(user.value!.name),
                              Text(user.value!.email),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text("Currency"),
                              trailing: DropdownMenu(
                                initialSelection: 'ID',
                                dropdownMenuEntries: [
                                  DropdownMenuEntry(value: 'ID', label: 'Rp.'),
                                ],
                              ),
                            ),
                            Consumer(
                              builder: (cotext, ref, child) => ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text("Log out"),
                                trailing: Icon(Icons.logout_rounded),
                                onTap: ref
                                    .read(authControllerProvider.notifier)
                                    .signOut,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

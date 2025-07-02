import 'package:drift_user_profile/providers/provider.dart';
import 'package:drift_user_profile/screens/home_screen.dart';
import 'package:drift_user_profile/screens/onboarding/profile_setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hasUserProvider = FutureProvider<bool>((ref) async {
  final db = ref.read(databaseProvider);
  final users = await db.getAllUsers();
  return users.isNotEmpty;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasUserAsync = ref.watch(hasUserProvider);

    return hasUserAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Something error')),
      data: (hasUser) =>
          MaterialApp(home: hasUser ? HomeScreen() : OnboardingScreen()),
    );
  }
}

import 'package:drift_user_profile/providers/provider.dart';
import 'package:drift_user_profile/services/database.dart';
import 'package:drift_user_profile/utility/image_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// Home screen widget that displays user profile information
// Uses Riverpod's ConsumerWidget for state management
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Access the database provider to fetch user data
    final db = ref.watch(databaseProvider);

    // Use FutureBuilder to handle asynchronous user data loading
    return FutureBuilder<List<User>>(
      future: db.getAllUsers(), // Fetch all users from database
      builder: (context, snapshot) {
        // Show loading indicator while data is being fetched
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error message if data fetching fails
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Get users list or empty list if null
        final users = snapshot.data ?? [];

        // Show message if no users found
        if (users.isEmpty) {
          return const Center(child: Text('No users found'));
        }

        // For simplicity, use the first user in the list
        final currentUser = users.first;

        return Material(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // User profile avatar
                CircleAvatar(
                  radius: 50,
                  backgroundImage: getProfileImage(currentUser.profileImage),
                ),
                const SizedBox(height: 16),

                // User name
                Text('Name: ${currentUser.name}'),
                const SizedBox(height: 8),

                // Email (conditional display)
                if (currentUser.email != null)
                  Text('Email: ${currentUser.email}'),
                const SizedBox(height: 8),

                // Bio (conditional display)
                if (currentUser.bio != null) Text('Bio: ${currentUser.bio}'),
                const SizedBox(height: 8),

                // Last updated timestamp
                Text(
                  'Last Updated: ${DateFormat('MMM dd, yyyy').format(currentUser.updatedAt)}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

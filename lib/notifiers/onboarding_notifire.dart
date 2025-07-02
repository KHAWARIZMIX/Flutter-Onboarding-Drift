import 'package:drift_user_profile/providers/provider.dart';
import 'package:drift_user_profile/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';

/// Manages the state and business logic for the onboarding process.
/// Handles user profile data updates and persistence using Riverpod's StateNotifier.
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final AppDatabase db; // Database instance for persisting user data

  /// Initializes the notifier with database instance and default state
  OnboardingNotifier(this.db) : super(OnboardingState());

  /// Updates the user's name in the state
  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  /// Updates the profile image URL/path in the state
  /// Note: This handles both local paths (for preview) and final URLs
  Future<void> updateProfileImage(String imageUrl) async {
    state = state.copyWith(profileImage: imageUrl);
  }

  /// Updates the user's email in the state
  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  /// Updates the user's bio in the state
  void updateBio(String bio) {
    state = state.copyWith(bio: bio);
  }

  /// Advances to the next onboarding page
  void nextPage() {
    state = state.copyWith(currentPage: state.currentPage + 1);
  }

  /// Directly sets the current onboarding page
  /// Used for back navigation and page control
  void updateCurrentPage(int currentPage) {
    state = state.copyWith(currentPage: currentPage);
  }

  /// Persists the complete user profile to the database
  /// Creates a UsersCompanion with all current state values
  Future<void> saveProfile(AppDatabase db) async {
    final userCompanion = UsersCompanion(
      name: Value(state.name),
      email: Value(state.email),
      bio: Value(state.bio),
      profileImage: Value(state.profileImage),
      updatedAt: Value(DateTime.now()), // Sets current timestamp
    );

    await db.insertUser(userCompanion);
  }
}
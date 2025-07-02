import 'package:drift_user_profile/notifiers/onboarding_notifire.dart';
import 'package:drift_user_profile/services/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// Represents the immutable state of the onboarding process.
/// Stores all user-provided data and tracks current onboarding progress.
class OnboardingState {
  /// User's full name (empty string if not provided yet)
  final String name;

  /// User's email address (empty string if not provided yet)
  final String email;

  /// User's biography/description (empty string if not provided yet)
  final String bio;

  /// URL or path to the user's profile image 
  /// (empty string if no image selected yet)
  final String profileImage;

  /// Current page index in the onboarding flow (0-based)
  /// Tracks which step the user is currently on
  final int currentPage;

  /// Creates an onboarding state with default empty values
  const OnboardingState({
    this.name = '',
    this.email = '',
    this.bio = '',
    this.profileImage = '',
    this.currentPage = 0,
  });

  /// Creates a new state by copying the current state and updating
  /// only the specified properties (null values will keep current values)
  /// 
  /// This immutable update pattern enables:
  /// 1. Predictable state management
  /// 2. Easy change tracking
  /// 3. Efficient widget rebuilds
  OnboardingState copyWith({
    String? name,
    String? email,
    String? bio,
    String? profileImage,
    int? currentPage,
  }) {
    return OnboardingState(
      name: name ?? this.name,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      profileImage: profileImage ?? this.profileImage,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  /// Optionally add equality comparison and toString() for debugging:
  /// @override
  /// bool operator ==(Object other) => ...
  /// 
  /// @override 
  /// int get hashCode => ...
  /// 
  /// @override
  /// String toString() => ...
}

/// Provides singleton access to the application database instance.
/// Manages the database lifecycle and ensures proper disposal when no longer needed.
final databaseProvider = Provider<AppDatabase>((ref) {
  // Initialize the database instance
  final db = AppDatabase();

  // Register cleanup to close database when provider is disposed
  ref.onDispose(() {
    db.close();
  });

  return db;
});

/// Provides state management for the onboarding process.
/// Combines:
/// - Access to database (via databaseProvider)
/// - Onboarding state management
/// - Business logic for user profile creation
final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  // Get database instance from databaseProvider
  final db = ref.read(databaseProvider);
  
  // Initialize onboarding notifier with database access
  return OnboardingNotifier(db);
});

/// Checks if any user exists in the database.
/// Used to determine if onboarding should be shown.
/// 
/// Returns:
///   Future<bool> - true if users exist, false if database is empty
Future<bool> loadUserFromDatabase(WidgetRef ref) async {
  // Access current database instance
  final db = ref.watch(databaseProvider);
  
  // Query all users from database
  final users = await db.getAllUsers();
  
  // Return whether any users exist
  return users.isNotEmpty;
}
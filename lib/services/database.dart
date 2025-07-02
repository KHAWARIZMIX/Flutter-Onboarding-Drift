import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_user_profile/model/user_table.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

@DriftDatabase(tables: [Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // USERS
  /// Retrieves all users from the database.
  Future<List<User>> getAllUsers() => select(users).get();

  /// Watches all users for real-time updates.
  Stream<List<User>> watchAllUsers() => select(users).watch();

  /// Inserts a new user and returns the inserted ID.
  /// Throws an exception if the insertion fails (e.g., duplicate key).
  Future<int> insertUser(UsersCompanion user) async {
    try {
      return await into(users).insert(user, onConflict: DoNothing());
    } catch (e) {
      throw DatabaseException('Failed to insert user: $e');
    }
  }

  /// Updates an existing user and returns the number of affected rows.
  Future<int> updateUser(User user) async {
    try {
      final result = await update(users).replace(user);
      return result ? 1 : 0; // Drift's replace returns a boolean
    } catch (e) {
      throw DatabaseException('Failed to update user: $e');
    }
  }

  /// Deletes a user by ID and returns the number of affected rows.
  Future<int> deleteUser(int id) async {
    try {
      return await (delete(users)..where((tbl) => tbl.id.equals(id))).go();
    } catch (e) {
      throw DatabaseException('Failed to delete user: $e');
    }
  }

  /// Retrieves a user by ID, or null if not found.
  Future<User?> getUserById(int id) {
    return (select(users)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}

// Custom exception for database errors
class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);

  @override
  String toString() => message;
}

// Database file location setup
LazyDatabase _openConnection() {
  const dbName = 'app.db'; // Make configurable if needed
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, dbName));
    return NativeDatabase(file);
  });
}

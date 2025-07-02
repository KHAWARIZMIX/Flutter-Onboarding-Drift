// drift_db.dart
import 'package:drift/drift.dart';

/// Defines the database schema for the Users table using Moor/Drift.
/// Each field represents a column in the SQLite database.
class Users extends Table {
  /// Auto-incrementing primary key column
  IntColumn get id => integer().autoIncrement()();

  /// User's full name (required)
  /// Uses SQLite TEXT type with no nulls allowed by default
  TextColumn get name => text()();

  /// User's email address (optional)
  /// Marked as nullable since not all users may provide an email
  TextColumn get email => text().nullable()();

  /// User biography/description (optional)
  /// Marked as nullable since bio is optional
  TextColumn get bio => text().nullable()();

  /// URL or path to user's profile image (required)
  /// Stores either:
  /// - Network URL (https://...)
  /// - Local file path (/data/...)
  /// - Base64 encoded image data
  TextColumn get profileImage => text()();

  /// Timestamp of last profile update
  /// Automatically defaults to current time when record is created/updated
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  /// Note: Moor/Drift will automatically generate:
  /// - Appropriate SQLite column types
  /// - NULL constraints based on nullable() modifier
  /// - Default values where specified
  /// - Primary key relationships
}
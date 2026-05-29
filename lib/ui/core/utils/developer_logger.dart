import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class DebugLogger {
  /// Logs a Firestore access error to the developer console when in debug mode.
  static void firestoreError({
    required String operation,
    required String collection,
    required Object error,
    StackTrace? stackTrace,
    String? docId,
  }) {
    if (kDebugMode) {
      final buffer = StringBuffer()
        ..write('🔥 [Firestore Error] ')
        ..write('Operation: $operation')
        ..write(' | Collection: $collection');
      
      if (docId != null) {
        buffer.write(' | Document ID: $docId');
      }
      
      buffer.write('\nDetails: $error');

      developer.log(
        buffer.toString(),
        name: 'firestore',
        level: 1000, // Severe
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  /// Logs general informational messages to the developer console when in debug mode.
  static void info(String message, {String name = 'app'}) {
    if (kDebugMode) {
      developer.log(
        message,
        name: name,
        level: 800, // Info
      );
    }
  }
}

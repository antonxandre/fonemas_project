import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/user_progress.dart';
import '../../domain/repositories/user_progress_repository.dart';
import '../../ui/core/utils/developer_logger.dart';

class FirebaseUserProgressRepository implements UserProgressRepository {
  final FirebaseFirestore _firestore;

  FirebaseUserProgressRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<UserProgress?> getUserProgress(String uid) async {
    try {
      final doc = await _firestore.collection('user_progress').doc(uid).get();
      if (doc.exists) {
        return UserProgress.fromMap(doc.data()!, doc.id);
      }
      return null;
    } catch (e, stack) {
      DebugLogger.firestoreError(
        operation: 'getUserProgress',
        collection: 'user_progress',
        docId: uid,
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }

  @override
  Future<void> markPhonemeCompleted(String uid, String phonemeId) async {
    try {
      final docRef = _firestore.collection('user_progress').doc(uid);
      
      // Use FieldValue.arrayUnion to safely add to the list without duplicates
      await docRef.set({
        'completedPhonemes': FieldValue.arrayUnion([phonemeId])
      }, SetOptions(merge: true));
    } catch (e, stack) {
      DebugLogger.firestoreError(
        operation: 'markPhonemeCompleted',
        collection: 'user_progress',
        docId: uid,
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }
}

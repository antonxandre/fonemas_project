import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/user_progress.dart';
import '../../domain/repositories/user_progress_repository.dart';

class FirebaseUserProgressRepository implements UserProgressRepository {
  final FirebaseFirestore _firestore;

  FirebaseUserProgressRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<UserProgress?> getUserProgress(String uid) async {
    final doc = await _firestore.collection('user_progress').doc(uid).get();
    if (doc.exists) {
      return UserProgress.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  @override
  Future<void> markPhonemeCompleted(String uid, String phonemeId) async {
    final docRef = _firestore.collection('user_progress').doc(uid);
    
    // Use FieldValue.arrayUnion to safely add to the list without duplicates
    await docRef.set({
      'completedPhonemes': FieldValue.arrayUnion([phonemeId])
    }, SetOptions(merge: true));
  }
}

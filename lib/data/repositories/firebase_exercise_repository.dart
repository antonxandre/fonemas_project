import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/exercise.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../../ui/core/utils/developer_logger.dart';

class FirebaseExerciseRepository implements ExerciseRepository {
  final FirebaseFirestore _firestore;

  FirebaseExerciseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Exercise>> getExercisesForTrack(String trackId) async {
    try {
      // trackId here actually represents the phonemeId that was passed from TrackSubPathPage
      final snapshot = await _firestore
          .collection('exercises')
          .where('phonemeId', isEqualTo: trackId)
          .get();

      return snapshot.docs.map((doc) {
        return Exercise.fromMap(doc.data(), doc.id);
      }).toList();
    } catch (e, stack) {
      DebugLogger.firestoreError(
        operation: 'getExercisesForTrack',
        collection: 'exercises',
        error: e,
        stackTrace: stack,
      );
      rethrow;
    }
  }
}

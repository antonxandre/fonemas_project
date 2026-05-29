import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/exercise.dart';
import '../../domain/repositories/exercise_repository.dart';

class FirebaseExerciseRepository implements ExerciseRepository {
  final FirebaseFirestore _firestore;

  FirebaseExerciseRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Exercise>> getExercisesForTrack(String trackId) async {
    // trackId here actually represents the phonemeId that was passed from TrackSubPathPage
    final snapshot = await _firestore
        .collection('exercises')
        .where('phonemeId', isEqualTo: trackId)
        .get();

    return snapshot.docs.map((doc) {
      return Exercise.fromMap(doc.data(), doc.id);
    }).toList();
  }
}

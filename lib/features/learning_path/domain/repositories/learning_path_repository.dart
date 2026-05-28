import '../entities/learning_track.dart';

abstract class LearningPathRepository {
  Future<List<LearningTrack>> getLearningTracks();
}

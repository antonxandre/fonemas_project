import '../models/user_progress.dart';

abstract class UserProgressRepository {
  Future<UserProgress?> getUserProgress(String uid);
  Future<void> markPhonemeCompleted(String uid, String phonemeId);
}

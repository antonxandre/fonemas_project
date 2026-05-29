import 'package:flutter/foundation.dart';
import '../../../../../domain/models/exercise.dart';
import '../../../../../domain/repositories/exercise_repository.dart';
import '../../../../../domain/repositories/user_progress_repository.dart';

class ExerciseViewModel extends ChangeNotifier {
  final ExerciseRepository _repository;
  final UserProgressRepository _progressRepository;
  final String _uid;

  ExerciseViewModel(this._repository, this._progressRepository, this._uid);

  List<Exercise> _exercises = [];
  List<Exercise> get exercises => _exercises;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  String? _selectedOption;
  String? get selectedOption => _selectedOption;

  bool? _isAnswerCorrect;
  bool? get isAnswerCorrect => _isAnswerCorrect;

  bool _isReplayingAudio = false;
  bool get isReplayingAudio => _isReplayingAudio;

  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _trackId;

  Exercise get currentExercise => _exercises[_currentIndex];

  Future<void> loadExercises(String trackId) async {
    _trackId = trackId;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _exercises = await _repository.getExercisesForTrack(trackId);
      _currentIndex = 0;
      _selectedOption = null;
      _isAnswerCorrect = null;
      _isReplayingAudio = false;
      _isCompleted = false;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectOption(String option) async {
    if (_isAnswerCorrect == true) return; // Prevent double taps during transition

    final isCorrect = option == currentExercise.correctOption;
    _selectedOption = option;
    _isAnswerCorrect = isCorrect;
    notifyListeners();

    if (isCorrect) {
      await Future.delayed(const Duration(milliseconds: 1200));
      
      if (_currentIndex < _exercises.length - 1) {
        _currentIndex += 1;
        _selectedOption = null;
        _isAnswerCorrect = null;
      } else {
        _isCompleted = true;
        if (_trackId != null) {
          try {
            await _progressRepository.markPhonemeCompleted(_uid, _trackId!);
          } catch (e) {
            debugPrint('Failed to mark phoneme completed: $e');
          }
        }
      }
      notifyListeners();
    } else {
      // Wrong answer - shake and reset selection to try again after delay
      await Future.delayed(const Duration(milliseconds: 1000));
      _selectedOption = null;
      _isAnswerCorrect = null;
      notifyListeners();
    }
  }

  Future<void> replayAudio() async {
    if (_isReplayingAudio) return;

    _isReplayingAudio = true;
    notifyListeners();
    
    await Future.delayed(const Duration(milliseconds: 800));
    
    _isReplayingAudio = false;
    notifyListeners();
  }
}

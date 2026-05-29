import 'package:flutter/foundation.dart';
import '../../../../domain/models/phoneme.dart';
import '../../../../domain/repositories/phoneme_repository.dart';
import '../../../../domain/repositories/user_progress_repository.dart';

class TrackSubPathViewModel extends ChangeNotifier {
  final PhonemeRepository _repository;
  final UserProgressRepository _progressRepository;
  final String _uid;
  
  List<Phoneme> _phonemes = [];
  List<String> _completedPhonemeIds = [];
  bool _isLoading = false;
  String? _errorMessage;

  TrackSubPathViewModel(this._repository, this._progressRepository, this._uid);

  List<Phoneme> get phonemes => _phonemes;
  List<String> get completedPhonemeIds => _completedPhonemeIds;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadPhonemes(String trackId, {String? subCategoryId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final futures = await Future.wait([
        _repository.getPhonemesByCategory(trackId, subCategoryId: subCategoryId),
        _progressRepository.getUserProgress(_uid),
      ]);
      
      _phonemes = futures[0] as List<Phoneme>;
      final userProgress = futures[1];
      
      if (userProgress != null) {
        // cast requires importing UserProgress model, but we can just avoid strong typing issues by doing this:
        _completedPhonemeIds = (userProgress as dynamic).completedPhonemes;
      } else {
        _completedPhonemeIds = [];
      }
    } catch (e) {
      _errorMessage = 'Erro ao carregar fonemas: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

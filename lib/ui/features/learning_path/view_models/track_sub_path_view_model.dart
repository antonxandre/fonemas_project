import 'package:flutter/foundation.dart';
import '../../../../domain/models/phoneme.dart';
import '../../../../domain/repositories/phoneme_repository.dart';

class TrackSubPathViewModel extends ChangeNotifier {
  final PhonemeRepository _repository;
  
  List<Phoneme> _phonemes = [];
  bool _isLoading = false;
  String? _errorMessage;

  TrackSubPathViewModel(this._repository);

  List<Phoneme> get phonemes => _phonemes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadPhonemes(String trackId, {String? subCategoryId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _phonemes = await _repository.getPhonemesByCategory(trackId, subCategoryId: subCategoryId);
    } catch (e) {
      _errorMessage = 'Erro ao carregar fonemas: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

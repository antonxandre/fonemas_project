import 'package:flutter/foundation.dart';
import '../../../../../domain/models/learning_track.dart';
import '../../../../../domain/repositories/learning_path_repository.dart';

class LearningPathViewModel extends ChangeNotifier {
  final LearningPathRepository _repository;

  LearningPathViewModel(this._repository);

  List<LearningTrack> _tracks = [];
  List<LearningTrack> get tracks => _tracks;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadTracks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _tracks = await _repository.getLearningTracks();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:flutter/foundation.dart';
import '../../../../../domain/models/book.dart';
import '../../../../../domain/repositories/study_repository.dart';

class BookReadingViewModel extends ChangeNotifier {
  final StudyRepository _repository;

  BookReadingViewModel(this._repository);

  Book? _book;
  Book? get book => _book;

  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  bool _isCompleted = false;
  bool get isCompleted => _isCompleted;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadBook(String bookId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final book = await _repository.getBookById(bookId);
      if (book != null) {
        _book = book;
        _currentPageIndex = 0;
        _isCompleted = false;
      } else {
        _errorMessage = 'Livro não encontrado.';
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void nextPage() {
    final book = _book;
    if (book == null) return;

    if (_currentPageIndex < book.pages.length - 1) {
      _currentPageIndex += 1;
    } else {
      _isCompleted = true;
    }
    notifyListeners();
  }

  void prevPage() {
    if (_currentPageIndex > 0) {
      _currentPageIndex -= 1;
      notifyListeners();
    }
  }
}

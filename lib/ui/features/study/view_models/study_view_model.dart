import 'package:flutter/foundation.dart';
import '../../../../../domain/models/book.dart';
import '../../../../../domain/repositories/study_repository.dart';

class StudyViewModel extends ChangeNotifier {
  final StudyRepository _repository;

  StudyViewModel(this._repository);

  List<Book> _books = [];
  List<Book> get books => _books;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadBooks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _books = await _repository.getBooks();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

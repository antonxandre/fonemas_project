import '../models/book.dart';

abstract class StudyRepository {
  Future<List<Book>> getBooks();
  Future<Book?> getBookById(String id);
}

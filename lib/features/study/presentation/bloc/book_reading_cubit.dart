import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/study_repository.dart';
import 'book_reading_state.dart';

class BookReadingCubit extends Cubit<BookReadingState> {
  final StudyRepository _repository;

  BookReadingCubit(this._repository) : super(const BookReadingInitial());

  Future<void> loadBook(String bookId) async {
    emit(const BookReadingLoading());
    try {
      final book = await _repository.getBookById(bookId);
      if (book != null) {
        emit(BookReadingLoaded(book: book));
      } else {
        emit(const BookReadingError('Livro não encontrado.'));
      }
    } catch (e) {
      emit(BookReadingError(e.toString()));
    }
  }

  void nextPage() {
    final currentState = state;
    if (currentState is! BookReadingLoaded) return;

    if (currentState.currentPageIndex < currentState.book.pages.length - 1) {
      emit(currentState.copyWith(
        currentPageIndex: currentState.currentPageIndex + 1,
      ));
    } else {
      emit(currentState.copyWith(isCompleted: true));
    }
  }

  void prevPage() {
    final currentState = state;
    if (currentState is! BookReadingLoaded) return;

    if (currentState.currentPageIndex > 0) {
      emit(currentState.copyWith(
        currentPageIndex: currentState.currentPageIndex - 1,
      ));
    }
  }
}

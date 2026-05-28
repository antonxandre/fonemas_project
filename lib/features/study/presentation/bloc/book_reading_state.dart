import 'package:equatable/equatable.dart';
import '../../domain/entities/book.dart';

sealed class BookReadingState extends Equatable {
  const BookReadingState();

  @override
  List<Object?> get props => [];
}

class BookReadingInitial extends BookReadingState {
  const BookReadingInitial();
}

class BookReadingLoading extends BookReadingState {
  const BookReadingLoading();
}

class BookReadingLoaded extends BookReadingState {
  final Book book;
  final int currentPageIndex;
  final bool isCompleted;

  const BookReadingLoaded({
    required this.book,
    this.currentPageIndex = 0,
    this.isCompleted = false,
  });

  BookReadingLoaded copyWith({
    Book? book,
    int? currentPageIndex,
    bool? isCompleted,
  }) {
    return BookReadingLoaded(
      book: book ?? this.book,
      currentPageIndex: currentPageIndex ?? this.currentPageIndex,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [book, currentPageIndex, isCompleted];
}

class BookReadingError extends BookReadingState {
  final String message;

  const BookReadingError(this.message);

  @override
  List<Object?> get props => [message];
}

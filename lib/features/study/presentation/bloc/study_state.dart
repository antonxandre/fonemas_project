import 'package:equatable/equatable.dart';
import '../../domain/entities/book.dart';

sealed class StudyState extends Equatable {
  const StudyState();

  @override
  List<Object?> get props => [];
}

class StudyInitial extends StudyState {
  const StudyInitial();
}

class StudyLoading extends StudyState {
  const StudyLoading();
}

class StudyLoaded extends StudyState {
  final List<Book> books;

  const StudyLoaded(this.books);

  @override
  List<Object?> get props => [books];
}

class StudyError extends StudyState {
  final String message;

  const StudyError(this.message);

  @override
  List<Object?> get props => [message];
}

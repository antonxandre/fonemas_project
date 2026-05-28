import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/study_repository.dart';
import 'study_state.dart';

class StudyCubit extends Cubit<StudyState> {
  final StudyRepository _repository;

  StudyCubit(this._repository) : super(const StudyInitial());

  Future<void> loadBooks() async {
    emit(const StudyLoading());
    try {
      final books = await _repository.getBooks();
      emit(StudyLoaded(books));
    } catch (e) {
      emit(StudyError(e.toString()));
    }
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/learning_path_repository.dart';
import 'learning_path_state.dart';

class LearningPathCubit extends Cubit<LearningPathState> {
  final LearningPathRepository _repository;

  LearningPathCubit(this._repository) : super(const LearningPathInitial());

  Future<void> loadTracks() async {
    emit(const LearningPathLoading());
    try {
      final tracks = await _repository.getLearningTracks();
      emit(LearningPathLoaded(tracks));
    } catch (e) {
      emit(LearningPathError(e.toString()));
    }
  }
}

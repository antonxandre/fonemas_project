import 'package:equatable/equatable.dart';
import '../../domain/entities/learning_track.dart';

sealed class LearningPathState extends Equatable {
  const LearningPathState();

  @override
  List<Object?> get props => [];
}

class LearningPathInitial extends LearningPathState {
  const LearningPathInitial();
}

class LearningPathLoading extends LearningPathState {
  const LearningPathLoading();
}

class LearningPathLoaded extends LearningPathState {
  final List<LearningTrack> tracks;

  const LearningPathLoaded(this.tracks);

  @override
  List<Object?> get props => [tracks];
}

class LearningPathError extends LearningPathState {
  final String message;

  const LearningPathError(this.message);

  @override
  List<Object?> get props => [message];
}

class ExerciseOption {
  final String text;
  final String? imageUrl;

  const ExerciseOption({
    required this.text,
    this.imageUrl,
  });
}

class Exercise {
  final String id;
  final String type; // e.g. "minimal_pairs"
  final String prompt; // e.g. "Onde está o som certo?"
  final List<ExerciseOption> options;
  final String correctOption; // Matches Option.text
  final String? audioUrl;

  const Exercise({
    required this.id,
    required this.type,
    required this.prompt,
    required this.options,
    required this.correctOption,
    this.audioUrl,
  });
}

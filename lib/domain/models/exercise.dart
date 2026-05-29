class ExerciseOption {
  final String text;
  final String? imageUrl;

  const ExerciseOption({
    required this.text,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'imageUrl': imageUrl,
    };
  }

  factory ExerciseOption.fromMap(Map<String, dynamic> map) {
    return ExerciseOption(
      text: map['text'] ?? '',
      imageUrl: map['imageUrl'],
    );
  }
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

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'prompt': prompt,
      'options': options.map((x) => x.toMap()).toList(),
      'correctOption': correctOption,
      'audioUrl': audioUrl,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map, String documentId) {
    return Exercise(
      id: documentId,
      type: map['type'] ?? '',
      prompt: map['prompt'] ?? '',
      options: List<ExerciseOption>.from(
        (map['options'] as List? ?? []).map((x) => ExerciseOption.fromMap(x)),
      ),
      correctOption: map['correctOption'] ?? '',
      audioUrl: map['audioUrl'],
    );
  }
}

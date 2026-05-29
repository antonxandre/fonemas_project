class UserProgress {
  final String uid;
  final List<String> completedPhonemes;

  const UserProgress({
    required this.uid,
    required this.completedPhonemes,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'completedPhonemes': completedPhonemes,
    };
  }

  factory UserProgress.fromMap(Map<String, dynamic> map, String documentId) {
    return UserProgress(
      uid: documentId,
      completedPhonemes: List<String>.from(map['completedPhonemes'] ?? []),
    );
  }
}

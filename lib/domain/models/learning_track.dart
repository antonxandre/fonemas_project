enum TrackStatus {
  completed,
  active,
  locked,
}

class LearningTrack {
  final String id;
  final String title;
  final String subtitle;
  final TrackStatus status;
  final String? abbreviation; // e.g. "Ae" for Vogais
  final int bgColorHex;
  final int textColorHex;
  final int borderColorHex;

  const LearningTrack({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.status,
    this.abbreviation,
    required this.bgColorHex,
    required this.textColorHex,
    required this.borderColorHex,
  });
}

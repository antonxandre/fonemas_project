import 'package:flutter/material.dart';

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
  final Color bgColor;
  final Color textColor;
  final Color borderColor;

  const LearningTrack({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.status,
    this.abbreviation,
    required this.bgColor,
    required this.textColor,
    required this.borderColor,
  });
}

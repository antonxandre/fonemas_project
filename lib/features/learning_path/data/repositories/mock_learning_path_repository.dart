import 'package:flutter/material.dart';
import '../../domain/entities/learning_track.dart';
import '../../domain/repositories/learning_path_repository.dart';
import '../../../../core/theme/miki_design_system.dart';

class MockLearningPathRepository implements LearningPathRepository {
  @override
  Future<List<LearningTrack>> getLearningTracks() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    return [
      const LearningTrack(
        id: 'vogais',
        title: 'Vogais',
        subtitle: 'EXPLORAR OS SONS',
        status: TrackStatus.active,
        abbreviation: 'Ae',
        bgColor: Color(0x4DDFE1F9),      // bg-primary-container/30 (adjusted for Flutter)
        borderColor: Color(0x336B6E94),  // border-primary/20
        textColor: MikiColors.primary,
      ),
      const LearningTrack(
        id: 'bilabiais',
        title: 'Bilabiais',
        subtitle: 'PRATICAR COM OS LÁBIOS',
        status: TrackStatus.active,
        bgColor: Color(0x4DE0F2F5),      // bg-secondary-container/30
        borderColor: Color(0x335A7A7F),  // border-secondary/20
        textColor: MikiColors.secondary,
      ),
      const LearningTrack(
        id: 'alveolares',
        title: 'Alveolares',
        subtitle: 'APRENDER O PONTO DA LÍNGUA',
        status: TrackStatus.active, // This is the active/focused track in the mockup!
        bgColor: Color(0x4DFCE4E4),      // bg-tertiary-container/30
        borderColor: Color(0x338A6666),  // border-tertiary/20
        textColor: MikiColors.tertiary,
      ),
      const LearningTrack(
        id: 'velares',
        title: 'Velares',
        subtitle: 'DOMINAR A GARGANTA',
        status: TrackStatus.active,
        bgColor: Color(0x33E0E1F9),      // bg-primary-container/20
        borderColor: Color(0x336B6E94),  // border-primary/20
        textColor: MikiColors.primary,
      ),
      const LearningTrack(
        id: 'fricativas',
        title: 'Fricativas',
        subtitle: 'INSPIRAR O CHIADO',
        status: TrackStatus.active,
        bgColor: Color(0x33E0F2F5),      // bg-secondary-container/20
        borderColor: Color(0x335A7A7F),  // border-secondary/20
        textColor: MikiColors.secondary,
      ),
      const LearningTrack(
        id: 'pratica_diaria',
        title: 'Prática Diária',
        subtitle: 'FLORESCER TODO DIA',
        status: TrackStatus.active, // Final node with gradient and special animations
        bgColor: MikiColors.primary,
        borderColor: Color(0x666B6E94), // border-primary/40
        textColor: Colors.white,
      ),
    ];
  }
}

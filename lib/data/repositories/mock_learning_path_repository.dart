import '../../domain/models/learning_track.dart';
import '../../domain/repositories/learning_path_repository.dart';

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
        bgColorHex: 0x4DDFE1F9,      // bg-primary-container/30 (adjusted for Flutter)
        borderColorHex: 0x336B6E94,  // border-primary/20
        textColorHex: 0xFF6B6E94,    // MikiColors.primary
        subCategories: [
          LearningSubCategory(id: 'orais', title: 'Orais'),
          LearningSubCategory(id: 'nasais', title: 'Nasais'),
        ],
      ),
      const LearningTrack(
        id: 'bilabiais',
        title: 'Bilabiais',
        subtitle: 'PRATICAR COM OS LÁBIOS',
        status: TrackStatus.active,
        bgColorHex: 0x4DE0F2F5,      // bg-secondary-container/30
        borderColorHex: 0x335A7A7F,  // border-secondary/20
        textColorHex: 0xFF5A7A7F,    // MikiColors.secondary
        subCategories: [
          LearningSubCategory(id: 'surdas', title: 'Surdas'),
          LearningSubCategory(id: 'sonoras', title: 'Sonoras'),
        ],
      ),
      const LearningTrack(
        id: 'alveolares',
        title: 'Alveolares',
        subtitle: 'APRENDER O PONTO DA LÍNGUA',
        status: TrackStatus.active, // This is the active/focused track in the mockup!
        bgColorHex: 0x4DFCE4E4,      // bg-tertiary-container/30
        borderColorHex: 0x338A6666,  // border-tertiary/20
        textColorHex: 0xFF8A6666,    // MikiColors.tertiary
        subCategories: [
          LearningSubCategory(id: 'surdas', title: 'Surdas'),
          LearningSubCategory(id: 'sonoras', title: 'Sonoras'),
        ],
      ),
      const LearningTrack(
        id: 'velares',
        title: 'Velares',
        subtitle: 'DOMINAR A GARGANTA',
        status: TrackStatus.active,
        bgColorHex: 0x33E0E1F9,      // bg-primary-container/20
        borderColorHex: 0x336B6E94,  // border-primary/20
        textColorHex: 0xFF6B6E94,    // MikiColors.primary
        subCategories: [
          LearningSubCategory(id: 'surdas', title: 'Surdas'),
          LearningSubCategory(id: 'sonoras', title: 'Sonoras'),
        ],
      ),
      const LearningTrack(
        id: 'fricativas',
        title: 'Fricativas',
        subtitle: 'INSPIRAR O CHIADO',
        status: TrackStatus.active,
        bgColorHex: 0x33E0F2F5,      // bg-secondary-container/20
        borderColorHex: 0x335A7A7F,  // border-secondary/20
        textColorHex: 0xFF5A7A7F,    // MikiColors.secondary
        subCategories: [
          LearningSubCategory(id: 'surdas', title: 'Surdas'),
          LearningSubCategory(id: 'sonoras', title: 'Sonoras'),
        ],
      ),
      const LearningTrack(
        id: 'pratica_diaria',
        title: 'Prática Diária',
        subtitle: 'FLORESCER TODO DIA',
        status: TrackStatus.active, // Final node with gradient and special animations
        bgColorHex: 0xFF6B6E94,      // MikiColors.primary
        borderColorHex: 0x666B6E94,  // border-primary/40
        textColorHex: 0xFFFFFFFF,    // Colors.white
      ),
    ];
  }
}

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get learningPathTitle => 'Trilhas de Aprendizado';

  @override
  String get learningPathSubtitle =>
      'Encontre o caminho suave para a sua voz florescer hoje.';

  @override
  String get start => 'Início';

  @override
  String get errorLoadingTracks => 'Erro ao carregar trilhas';

  @override
  String get tryAgain => 'Tentar Novamente';

  @override
  String get congratulations => 'Parabéns!';

  @override
  String get completedAllExercises =>
      'Você concluiu com sucesso todos os exercícios de Pares Mínimos!';

  @override
  String get backToTrack => 'VOLTAR PARA A TRILHA';

  @override
  String get errorLoadingExercises => 'Erro ao carregar exercícios';

  @override
  String get minimalPairs => 'Pares Mínimos';

  @override
  String get replaying => 'REPRODUZINDO...';

  @override
  String get listenAgain => 'OUVIR NOVAMENTE';

  @override
  String exerciseProgress(int current, int total) {
    return 'Exercício $current de $total';
  }

  @override
  String get studyArea => 'Área de Estudos';

  @override
  String get studyDescription =>
      'Leia livros infantis especialmente criados para trabalhar fonemas.';

  @override
  String get readingModule => 'Módulo de Leitura';

  @override
  String get errorLoadingBooks => 'Erro ao carregar livros';

  @override
  String get profileTitle => 'Perfil do Usuário';

  @override
  String get profileSubtitle =>
      'Acompanhe seu progresso e conquistas clínicas.';

  @override
  String get mikiStyle => 'Miki Style';

  @override
  String get errorLoadingBook => 'Erro ao carregar o livro';

  @override
  String get whereIsSound => 'Onde está o som certo?';
}

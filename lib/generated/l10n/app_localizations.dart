import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('pt')];

  /// Title of the learning path section
  ///
  /// In pt, this message translates to:
  /// **'Trilhas de Aprendizado'**
  String get learningPathTitle;

  /// Subtitle of the learning path section
  ///
  /// In pt, this message translates to:
  /// **'Encontre o caminho suave para a sua voz florescer hoje.'**
  String get learningPathSubtitle;

  /// Label for start or home navigation
  ///
  /// In pt, this message translates to:
  /// **'Início'**
  String get start;

  /// Error message when tracks fail to load
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar trilhas'**
  String get errorLoadingTracks;

  /// Button label to retry loading
  ///
  /// In pt, this message translates to:
  /// **'Tentar Novamente'**
  String get tryAgain;

  /// Congratulatory dialog title
  ///
  /// In pt, this message translates to:
  /// **'Parabéns!'**
  String get congratulations;

  /// Success message when completing all exercises
  ///
  /// In pt, this message translates to:
  /// **'Você concluiu com sucesso todos os exercícios de Pares Mínimos!'**
  String get completedAllExercises;

  /// Button label to navigate back to the learning path
  ///
  /// In pt, this message translates to:
  /// **'VOLTAR PARA A TRILHA'**
  String get backToTrack;

  /// Error message when exercises fail to load
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar exercícios'**
  String get errorLoadingExercises;

  /// Title of the minimal pairs exercise
  ///
  /// In pt, this message translates to:
  /// **'Pares Mínimos'**
  String get minimalPairs;

  /// Status text while replaying audio
  ///
  /// In pt, this message translates to:
  /// **'REPRODUZINDO...'**
  String get replaying;

  /// Button label to play audio again
  ///
  /// In pt, this message translates to:
  /// **'OUVIR NOVAMENTE'**
  String get listenAgain;

  /// Label showing progress through exercises
  ///
  /// In pt, this message translates to:
  /// **'Exercício {current} de {total}'**
  String exerciseProgress(int current, int total);

  /// Title of the study section
  ///
  /// In pt, this message translates to:
  /// **'Área de Estudos'**
  String get studyArea;

  /// Subtitle of the study section
  ///
  /// In pt, this message translates to:
  /// **'Leia livros infantis especialmente criados para trabalhar fonemas.'**
  String get studyDescription;

  /// Header title of the reading session
  ///
  /// In pt, this message translates to:
  /// **'Módulo de Leitura'**
  String get readingModule;

  /// Error message when books fail to load
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar livros'**
  String get errorLoadingBooks;

  /// Title of the profile page
  ///
  /// In pt, this message translates to:
  /// **'Perfil do Usuário'**
  String get profileTitle;

  /// Subtitle of the profile page
  ///
  /// In pt, this message translates to:
  /// **'Acompanhe seu progresso e conquistas clínicas.'**
  String get profileSubtitle;

  /// Brand aesthetic tag
  ///
  /// In pt, this message translates to:
  /// **'Miki Style'**
  String get mikiStyle;

  /// Error message when a single book fails to load
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar o livro'**
  String get errorLoadingBook;

  /// Prompt for identifying correct sound image
  ///
  /// In pt, this message translates to:
  /// **'Onde está o som certo?'**
  String get whereIsSound;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

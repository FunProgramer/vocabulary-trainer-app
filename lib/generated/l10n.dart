// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Loading not started. Will be started soon.`
  String get loadingNotStarted {
    return Intl.message(
      'Loading not started. Will be started soon.',
      name: 'loadingNotStarted',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get anErrorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'anErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `More info:\n{errorString}`
  String moreInfoError(Object errorString) {
    return Intl.message(
      'More info:\n$errorString',
      name: 'moreInfoError',
      desc: '',
      args: [errorString],
    );
  }

  /// `About this app`
  String get aboutApp {
    return Intl.message(
      'About this app',
      name: 'aboutApp',
      desc: '',
      args: [],
    );
  }

  /// `An app to learn vocabularies, developed with flutter.`
  String get appDescription {
    return Intl.message(
      'An app to learn vocabularies, developed with flutter.',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `Created by FunProgramer`
  String get author {
    return Intl.message(
      'Created by FunProgramer',
      name: 'author',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't open the GitHub Website.`
  String get errorOpenGitHub {
    return Intl.message(
      'Couldn\'t open the GitHub Website.',
      name: 'errorOpenGitHub',
      desc: '',
      args: [],
    );
  }

  /// `Copy URL`
  String get copyUrl {
    return Intl.message(
      'Copy URL',
      name: 'copyUrl',
      desc: '',
      args: [],
    );
  }

  /// `Source Code`
  String get sourceCode {
    return Intl.message(
      'Source Code',
      name: 'sourceCode',
      desc: '',
      args: [],
    );
  }

  /// `In which language direction do you want to learn the vocabulary?`
  String get questionLanguageDirection {
    return Intl.message(
      'In which language direction do you want to learn the vocabulary?',
      name: 'questionLanguageDirection',
      desc: '',
      args: [],
    );
  }

  /// `Random for each vocabulary`
  String get randomForVocabulary {
    return Intl.message(
      'Random for each vocabulary',
      name: 'randomForVocabulary',
      desc: '',
      args: [],
    );
  }

  /// `In which order to you want to learn the vocabulary?`
  String get questionExerciseOrder {
    return Intl.message(
      'In which order to you want to learn the vocabulary?',
      name: 'questionExerciseOrder',
      desc: '',
      args: [],
    );
  }

  /// `Standard order`
  String get standardOrder {
    return Intl.message(
      'Standard order',
      name: 'standardOrder',
      desc: '',
      args: [],
    );
  }

  /// `Random order`
  String get randomOrder {
    return Intl.message(
      'Random order',
      name: 'randomOrder',
      desc: '',
      args: [],
    );
  }

  /// `BACK`
  String get back {
    return Intl.message(
      'BACK',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `START TRAINING`
  String get startTraining {
    return Intl.message(
      'START TRAINING',
      name: 'startTraining',
      desc: '',
      args: [],
    );
  }

  /// `NEXT`
  String get next {
    return Intl.message(
      'NEXT',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Learn vocabularies`
  String get learnVocabularies {
    return Intl.message(
      'Learn vocabularies',
      name: 'learnVocabularies',
      desc: '',
      args: [],
    );
  }

  /// `{howMany, plural, one{Delete Vocabulary Collection?} other{Delete {howMany} Vocabulary Collections?}}`
  String deleteVocabularyCollections(num howMany) {
    return Intl.plural(
      howMany,
      one: 'Delete Vocabulary Collection?',
      other: 'Delete $howMany Vocabulary Collections?',
      name: 'deleteVocabularyCollections',
      desc: '',
      args: [howMany],
    );
  }

  /// `{howMany, plural, one{Are you sure to delete a Vocabulary Collection?} other{Are you sure to delete {howMany} Vocabulary Collections?}}`
  String deleteVocabularyCollectionsFull(num howMany) {
    return Intl.plural(
      howMany,
      one: 'Are you sure to delete a Vocabulary Collection?',
      other: 'Are you sure to delete $howMany Vocabulary Collections?',
      name: 'deleteVocabularyCollectionsFull',
      desc: '',
      args: [howMany],
    );
  }

  /// `NO`
  String get no {
    return Intl.message(
      'NO',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get yes {
    return Intl.message(
      'YES',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Delete Vocabulary Collection`
  String get deletingVocabularyCollection {
    return Intl.message(
      'Delete Vocabulary Collection',
      name: 'deletingVocabularyCollection',
      desc: '',
      args: [],
    );
  }

  /// `Deleting`
  String get deleting {
    return Intl.message(
      'Deleting',
      name: 'deleting',
      desc: '',
      args: [],
    );
  }

  /// `Loading data...`
  String get loadingData {
    return Intl.message(
      'Loading data...',
      name: 'loadingData',
      desc: '',
      args: [],
    );
  }

  /// `No collections`
  String get noCollections {
    return Intl.message(
      'No collections',
      name: 'noCollections',
      desc: '',
      args: [],
    );
  }

  /// `Click on the plus icon in the bottom right corner to add one.`
  String get addCollectionHint {
    return Intl.message(
      'Click on the plus icon in the bottom right corner to add one.',
      name: 'addCollectionHint',
      desc: '',
      args: [],
    );
  }

  /// `{selectionLength} selected`
  String selectionInfo(Object selectionLength) {
    return Intl.message(
      '$selectionLength selected',
      name: 'selectionInfo',
      desc: '',
      args: [selectionLength],
    );
  }

  /// `Import Vocabulary Collection`
  String get importVocabularyCollection {
    return Intl.message(
      'Import Vocabulary Collection',
      name: 'importVocabularyCollection',
      desc: '',
      args: [],
    );
  }

  /// `Importing`
  String get importing {
    return Intl.message(
      'Importing',
      name: 'importing',
      desc: '',
      args: [],
    );
  }

  /// `Successfully imported Vocabulary Collection`
  String get successfulImport {
    return Intl.message(
      'Successfully imported Vocabulary Collection',
      name: 'successfulImport',
      desc: '',
      args: [],
    );
  }

  /// `Collection Details`
  String get collectionDetails {
    return Intl.message(
      'Collection Details',
      name: 'collectionDetails',
      desc: '',
      args: [],
    );
  }

  /// `Reading file...`
  String get readingFile {
    return Intl.message(
      'Reading file...',
      name: 'readingFile',
      desc: '',
      args: [],
    );
  }

  /// `Not available`
  String get notAvailable {
    return Intl.message(
      'Not available',
      name: 'notAvailable',
      desc: '',
      args: [],
    );
  }

  /// `User aborted file picking. Navigating back to previous page in a few seconds...`
  String get filePickingAborted {
    return Intl.message(
      'User aborted file picking. Navigating back to previous page in a few seconds...',
      name: 'filePickingAborted',
      desc: '',
      args: [],
    );
  }

  /// `No data found. That usually means, that the vocabulary collection does not exist.`
  String get noData {
    return Intl.message(
      'No data found. That usually means, that the vocabulary collection does not exist.',
      name: 'noData',
      desc: '',
      args: [],
    );
  }

  /// `The provided JSON-File is not in the correct format.`
  String get brokenFile {
    return Intl.message(
      'The provided JSON-File is not in the correct format.',
      name: 'brokenFile',
      desc: '',
      args: [],
    );
  }

  /// `Collection currently not imported. Click on the import icon in the bar above, to import this collection.`
  String get collectionNotImported {
    return Intl.message(
      'Collection currently not imported. Click on the import icon in the bar above, to import this collection.',
      name: 'collectionNotImported',
      desc: '',
      args: [],
    );
  }

  /// `{vocabularyLength} Vocabularies`
  String vocabularyCount(Object vocabularyLength) {
    return Intl.message(
      '$vocabularyLength Vocabularies',
      name: 'vocabularyCount',
      desc: '',
      args: [vocabularyLength],
    );
  }

  /// `SKIP`
  String get skip {
    return Intl.message(
      'SKIP',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `SUBMIT`
  String get submit {
    return Intl.message(
      'SUBMIT',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `You skipped this exercise.`
  String get skippedExercise {
    return Intl.message(
      'You skipped this exercise.',
      name: 'skippedExercise',
      desc: '',
      args: [],
    );
  }

  /// `Correct answer: {requestedAnswer}`
  String correctAnswer(Object requestedAnswer) {
    return Intl.message(
      'Correct answer: $requestedAnswer',
      name: 'correctAnswer',
      desc: '',
      args: [requestedAnswer],
    );
  }

  /// `Correct answer!`
  String get correctAnswerInfo {
    return Intl.message(
      'Correct answer!',
      name: 'correctAnswerInfo',
      desc: '',
      args: [],
    );
  }

  /// `Wrong answer!`
  String get wrongAnswer {
    return Intl.message(
      'Wrong answer!',
      name: 'wrongAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Original answer: {requestedAnswer}`
  String originalAnswer(Object requestedAnswer) {
    return Intl.message(
      'Original answer: $requestedAnswer',
      name: 'originalAnswer',
      desc: '',
      args: [requestedAnswer],
    );
  }

  /// `Training: {collectionTitle}`
  String trainingTitle(Object collectionTitle) {
    return Intl.message(
      'Training: $collectionTitle',
      name: 'trainingTitle',
      desc: '',
      args: [collectionTitle],
    );
  }

  /// `Unknown Language: {code}`
  String unknownLanguage(Object code) {
    return Intl.message(
      'Unknown Language: $code',
      name: 'unknownLanguage',
      desc: '',
      args: [code],
    );
  }

  /// `Show solution`
  String get showSolution {
    return Intl.message(
      'Show solution',
      name: 'showSolution',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

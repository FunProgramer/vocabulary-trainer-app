// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(requestedAnswer) => "Correct answer: ${requestedAnswer}";

  static String m1(howMany) =>
      "${Intl.plural(howMany, one: 'Delete Vocabulary Collection?', other: 'Delete ${howMany} Vocabulary Collections?')}";

  static String m2(howMany) =>
      "${Intl.plural(howMany, one: 'Are you sure to delete a Vocabulary Collection?', other: 'Are you sure to delete ${howMany} Vocabulary Collections?')}";

  static String m3(errorString) => "More info:\n${errorString}";

  static String m4(requestedAnswer) => "Original answer: ${requestedAnswer}";

  static String m5(selectionLength) => "${selectionLength} selected";

  static String m6(collectionTitle) => "Training: ${collectionTitle}";

  static String m7(code) => "Unknown Language: ${code}";

  static String m8(vocabularyLength) => "${vocabularyLength} Vocabularies";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutApp": MessageLookupByLibrary.simpleMessage("About this app"),
        "addCollectionHint": MessageLookupByLibrary.simpleMessage(
            "Click on the plus icon in the bottom right corner to add one."),
        "anErrorOccurred":
            MessageLookupByLibrary.simpleMessage("An error occurred"),
        "appDescription": MessageLookupByLibrary.simpleMessage(
            "An app to learn vocabularies, developed with flutter."),
        "author":
            MessageLookupByLibrary.simpleMessage("Created by FunProgramer"),
        "back": MessageLookupByLibrary.simpleMessage("BACK"),
        "brokenFile": MessageLookupByLibrary.simpleMessage(
            "The provided JSON-File is not in the correct format."),
        "collectionDetails":
            MessageLookupByLibrary.simpleMessage("Collection Details"),
        "collectionNotImported": MessageLookupByLibrary.simpleMessage(
            "Collection currently not imported. Click on the import icon in the bar above, to import this collection."),
        "copyUrl": MessageLookupByLibrary.simpleMessage("Copy URL"),
        "correctAnswer": m0,
        "correctAnswerInfo":
            MessageLookupByLibrary.simpleMessage("Correct answer!"),
        "deleteVocabularyCollections": m1,
        "deleteVocabularyCollectionsFull": m2,
        "deleting": MessageLookupByLibrary.simpleMessage("Deleting"),
        "deletingVocabularyCollection": MessageLookupByLibrary.simpleMessage(
            "Delete Vocabulary Collection"),
        "errorOpenGitHub": MessageLookupByLibrary.simpleMessage(
            "Couldn\'t open the GitHub Website."),
        "filePickingAborted": MessageLookupByLibrary.simpleMessage(
            "User aborted file picking. Navigating back to previous page in a few seconds..."),
        "importVocabularyCollection": MessageLookupByLibrary.simpleMessage(
            "Import Vocabulary Collection"),
        "importing": MessageLookupByLibrary.simpleMessage("Importing"),
        "learnVocabularies":
            MessageLookupByLibrary.simpleMessage("Learn vocabularies"),
        "loadingData": MessageLookupByLibrary.simpleMessage("Loading data..."),
        "loadingNotStarted": MessageLookupByLibrary.simpleMessage(
            "Loading not started. Will be started soon."),
        "moreInfoError": m3,
        "next": MessageLookupByLibrary.simpleMessage("NEXT"),
        "no": MessageLookupByLibrary.simpleMessage("NO"),
        "noCollections": MessageLookupByLibrary.simpleMessage("No collections"),
        "noData": MessageLookupByLibrary.simpleMessage(
            "No data found. That usually means, that the vocabulary collection does not exist."),
        "notAvailable": MessageLookupByLibrary.simpleMessage("Not available"),
        "originalAnswer": m4,
        "questionExerciseOrder": MessageLookupByLibrary.simpleMessage(
            "In which order to you want to learn the vocabulary?"),
        "questionLanguageDirection": MessageLookupByLibrary.simpleMessage(
            "In which language direction do you want to learn the vocabulary?"),
        "randomForVocabulary":
            MessageLookupByLibrary.simpleMessage("Random for each vocabulary"),
        "randomOrder": MessageLookupByLibrary.simpleMessage("Random order"),
        "readingFile": MessageLookupByLibrary.simpleMessage("Reading file..."),
        "selectionInfo": m5,
        "showSolution": MessageLookupByLibrary.simpleMessage("Show solution"),
        "skip": MessageLookupByLibrary.simpleMessage("SKIP"),
        "skippedExercise":
            MessageLookupByLibrary.simpleMessage("You skipped this exercise."),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Source Code"),
        "standardOrder": MessageLookupByLibrary.simpleMessage("Standard order"),
        "startTraining": MessageLookupByLibrary.simpleMessage("START TRAINING"),
        "submit": MessageLookupByLibrary.simpleMessage("SUBMIT"),
        "successfulImport": MessageLookupByLibrary.simpleMessage(
            "Successfully imported Vocabulary Collection"),
        "trainingTitle": m6,
        "unknownLanguage": m7,
        "vocabularyCount": m8,
        "wrongAnswer": MessageLookupByLibrary.simpleMessage("Wrong answer!"),
        "yes": MessageLookupByLibrary.simpleMessage("YES")
      };
}

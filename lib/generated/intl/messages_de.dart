// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a de locale. All the
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
  String get localeName => 'de';

  static String m0(requestedAnswer) => "Richtige Antwort: ${requestedAnswer}";

  static String m1(howMany) =>
      "${Intl.plural(howMany, one: 'Vokabel Sammlung löschen?', other: '${howMany} Vokabel Sammlungen löschen?')}";

  static String m2(howMany) =>
      "${Intl.plural(howMany, one: 'Bist du dir sicher, dass du eine Vokabel Sammlung löschen möchtest?', other: 'Bist du dir sicher, dass du ${howMany} Vokabel Sammlungen löschen möchtest?')}";

  static String m3(errorString) => "Weitere Informationen:\n${errorString}";

  static String m4(requestedAnswer) =>
      "Ursprüngliche Antwort: ${requestedAnswer}";

  static String m5(selectionLength) => "${selectionLength} ausgewählt";

  static String m6(collectionTitle) => "Training: ${collectionTitle}";

  static String m7(vocabularyLength) => "${vocabularyLength} Vokabeln";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutApp": MessageLookupByLibrary.simpleMessage("Über diese App"),
        "addCollectionHint": MessageLookupByLibrary.simpleMessage(
            "Klicke auf das Plus-Symbol in der unteren rechten Ecke um eine hinzuzufügen."),
        "anErrorOccurred":
            MessageLookupByLibrary.simpleMessage("Ein Fehler ist aufgetreten"),
        "appDescription": MessageLookupByLibrary.simpleMessage(
            "Eine App zum Lernen von Vokabeln, entwickelt mit Flutter"),
        "author":
            MessageLookupByLibrary.simpleMessage("Erstellt von FunProgramer"),
        "back": MessageLookupByLibrary.simpleMessage("ZURÜCK"),
        "brokenFile": MessageLookupByLibrary.simpleMessage(
            "Die angegebene JSON-Datei is nicht im richtigen Format."),
        "collectionDetails":
            MessageLookupByLibrary.simpleMessage("Details der Sammlung"),
        "collectionNotImported": MessageLookupByLibrary.simpleMessage(
            "Sammlung aktuell nicht importiert. Klicke auf das Importieren-Icon in der Leiste oben, um diese Sammlung zu importieren."),
        "copyUrl": MessageLookupByLibrary.simpleMessage("URL kopieren"),
        "correctAnswer": m0,
        "correctAnswerInfo":
            MessageLookupByLibrary.simpleMessage("Richtige Antwort!"),
        "deleteVocabularyCollections": m1,
        "deleteVocabularyCollectionsFull": m2,
        "deleting": MessageLookupByLibrary.simpleMessage("Wird gelöscht"),
        "deletingVocabularyCollection":
            MessageLookupByLibrary.simpleMessage("Vokabel Sammlung löschen"),
        "errorOpenGitHub": MessageLookupByLibrary.simpleMessage(
            "Die GitHub Website konnte nicht geöffnet werden."),
        "filePickingAborted": MessageLookupByLibrary.simpleMessage(
            "Der Benutzer hat die Datei-Auswahl abgebrochen. In ein paar Sekunden wird zurücknavigiert..."),
        "importVocabularyCollection": MessageLookupByLibrary.simpleMessage(
            "Vokabel Sammlung importieren"),
        "importing": MessageLookupByLibrary.simpleMessage("Wird importiert"),
        "learnVocabularies":
            MessageLookupByLibrary.simpleMessage("Vokabeln lernen"),
        "loadingData":
            MessageLookupByLibrary.simpleMessage("Daten werden geladen..."),
        "loadingNotStarted": MessageLookupByLibrary.simpleMessage(
            "Das Laden wurde noch nicht gestartet. Es wird bald gestartet."),
        "moreInfoError": m3,
        "next": MessageLookupByLibrary.simpleMessage("WEITER"),
        "no": MessageLookupByLibrary.simpleMessage("NEIN"),
        "noCollections":
            MessageLookupByLibrary.simpleMessage("Kein Sammlungen"),
        "noData": MessageLookupByLibrary.simpleMessage(
            "Keine Daten gefunden. Das bedeutet normalerweise, dass die Vokabel Sammlung nicht existiert"),
        "notAvailable": MessageLookupByLibrary.simpleMessage("Nicht verfügbar"),
        "originalAnswer": m4,
        "questionExerciseOrder": MessageLookupByLibrary.simpleMessage(
            "In welcher Reihenfolge möchtest du die Vokabeln lernen?"),
        "questionLanguageDirection": MessageLookupByLibrary.simpleMessage(
            "In welche Sprachrichtung möchtest du die Vokabeln lernen?"),
        "randomForVocabulary":
            MessageLookupByLibrary.simpleMessage("Zufällig für jede Vokabel"),
        "randomOrder":
            MessageLookupByLibrary.simpleMessage("Zufällige Reihenfolge"),
        "readingFile":
            MessageLookupByLibrary.simpleMessage("Datei wird gelesen..."),
        "selectionInfo": m5,
        "skip": MessageLookupByLibrary.simpleMessage("ÜBERSPRINGEN"),
        "skippedExercise": MessageLookupByLibrary.simpleMessage(
            "Du hast diese Übung übersprungen"),
        "sourceCode": MessageLookupByLibrary.simpleMessage("Quell Code"),
        "standardOrder":
            MessageLookupByLibrary.simpleMessage("Standard Reihenfolge"),
        "startTraining":
            MessageLookupByLibrary.simpleMessage("TRAINING BEGINNEN"),
        "submit": MessageLookupByLibrary.simpleMessage("ÜBERPRÜFEN"),
        "successfulImport": MessageLookupByLibrary.simpleMessage(
            "Die Vokabel Sammlung wurde erfolgreich importiert"),
        "trainingTitle": m6,
        "vocabularyCount": m7,
        "wrongAnswer": MessageLookupByLibrary.simpleMessage("Falsche Antwort!"),
        "yes": MessageLookupByLibrary.simpleMessage("JA")
      };
}

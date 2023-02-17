import 'package:vocabulary_trainer_app/models/complete_vocabulary_collection.dart';
import 'package:vocabulary_trainer_app/services/random.dart';

import '../models/exercise_state.dart';
import '../models/vocabulary.dart';

class Training {
  final String collectionTitle;
  final List<Exercise> exercises;

  Training._internalConstructor(this.collectionTitle, this.exercises);

}

class Exercise {
  final String providedLanguageName;
  final String providedLanguage;
  final String requestedLanguageName;
  final String requestedLanguage;
  final RegExp _requestedLanguageRegex;

  ExerciseState state = ExerciseState.notAnswered;
  String answer = "";

  Exercise._withStandardLanguageDirection(
      String languageAName, String languageBName, Vocabulary vocabulary)
      : providedLanguageName = languageAName,
        providedLanguage = vocabulary.languageA,
        requestedLanguageName = languageBName,
        requestedLanguage = vocabulary.languageB,
        _requestedLanguageRegex = RegExp("^${vocabulary.languageBRegex}\$");

  Exercise._withReverseLanguageDirection(
      String languageAName, String languageBName, Vocabulary vocabulary)
      : providedLanguageName = languageBName,
        providedLanguage = vocabulary.languageB,
        requestedLanguageName = languageAName,
        requestedLanguage = vocabulary.languageA,
        _requestedLanguageRegex = RegExp("^${vocabulary.languageARegex}\$");

  bool checkAnswer(String answer) {
    answer = answer.trim();

    return _requestedLanguageRegex.hasMatch(answer);
  }

  @override
  String toString() {
    return "$providedLanguage - ${answer == "" ? '?' : answer}";
  }
}

class TrainingBuilder {
  CompleteVocabularyCollection? vocabularyCollection;
  LanguageDirection _languageDirection = LanguageDirection.standard;
  ExerciseOrder _exerciseOrder = ExerciseOrder.standard;

  set languageDirection(LanguageDirection value) {
    _languageDirection = value;
  }

  set exerciseOrder(ExerciseOrder value) {
    _exerciseOrder = value;
  }
  
  Training build() {
   if (vocabularyCollection == null) {
     throw Exception("Trying to build Training without Vocabulary Collection!");
   }

   List<Vocabulary> vocabularies = [...vocabularyCollection!.vocabularies];
   List<Exercise> exercises = [];

   if (_exerciseOrder == ExerciseOrder.random) {
     vocabularies.shuffle();
   }

   switch (_languageDirection) {
     case LanguageDirection.standard:
       exercises = vocabularies.map((e) {
          return Exercise._withStandardLanguageDirection(
              vocabularyCollection!.languageA,
              vocabularyCollection!.languageB,
              e);
        }).toList();
       break;
     case LanguageDirection.reverse:
       exercises = vocabularies.map((e) {
         return Exercise._withReverseLanguageDirection(
             vocabularyCollection!.languageA,
             vocabularyCollection!.languageB,
             e);
       }).toList();
       break;
     case LanguageDirection.random:
       exercises = vocabularies.map((e) {
         int n = rand(0, 2);
         if (n == 0) {
           return Exercise._withStandardLanguageDirection(
               vocabularyCollection!.languageA,
               vocabularyCollection!.languageB,
               e);
         } else {
           return Exercise._withReverseLanguageDirection(
               vocabularyCollection!.languageA,
               vocabularyCollection!.languageB,
               e);
         }
       }).toList();
       break;
   }

   return Training._internalConstructor(vocabularyCollection!.title, exercises);
  }
}

abstract class TrainingCreationOption {}

enum LanguageDirection implements TrainingCreationOption {
  standard,
  reverse,
  random
}

enum ExerciseOrder implements TrainingCreationOption {
  standard,
  random
}
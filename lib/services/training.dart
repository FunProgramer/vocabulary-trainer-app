import 'package:flutter/cupertino.dart';
import 'package:vocabulary_trainer_app/models/complete_vocabulary_collection.dart';
import 'package:vocabulary_trainer_app/services/random.dart';

import '../models/exercise_state.dart';
import '../models/vocabulary.dart';

class Training {
  final String collectionTitle;
  final List<Exercise> exercises;

  Training._internalConstructor(this.collectionTitle, this.exercises);

  void reset() {
    for (Exercise exercise in exercises) {
      exercise.state = ExerciseState.notAnswered;
      exercise.removeAnswer();
    }
  }

  List<Exercise> getCorrectAnsweredExercises() {
    return exercises
        .where((element) => element.state == ExerciseState.correctAnswered)
        .toList(growable: false);
  }

  List<Exercise> getWrongAnsweredExercises() {
    return exercises
        .where((element) => element.state == ExerciseState.wrongAnswered)
        .toList(growable: false);
  }

  List<Exercise> getSkippedExercises() {
    return exercises
        .where((element) => element.state == ExerciseState.skipped)
        .toList(growable: false);
  }

  int getNumberOfFinishedExercises() {
    return exercises
        .where((element) => element.state != ExerciseState.notAnswered).length;
  }

}

class Exercise {
  final String providedLanguageName;
  final String providedLanguage;
  final String requestedLanguageName;
  final String requestedLanguage;
  final RegExp _requestedLanguageRegex;

  ExerciseState state = ExerciseState.notAnswered;
  String _answer = "";

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

  String get answer => _answer;

  void checkAnswer(String answer) {
    _answer = answer.trim();

    if (_requestedLanguageRegex.hasMatch(_answer)) {
      state = ExerciseState.correctAnswered;
    } else {
      state = ExerciseState.wrongAnswered;
    }
  }

  void removeAnswer() {
    _answer = "";
  }

  @override
  String toString() {
    return "$providedLanguage - ${answer == "" ? '?' : answer}";
  }
}

class TrainingBuilder {
  CompleteVocabularyCollection? vocabularyCollection;
  LanguageDirection languageDirection = LanguageDirection.standard;
  ExerciseOrder exerciseOrder = ExerciseOrder.standard;
  
  Training build(BuildContext context) {
   if (vocabularyCollection == null) {
     throw Exception("Trying to build Training without Vocabulary Collection!");
   }

   List<Vocabulary> vocabularies = [...vocabularyCollection!.vocabularies];
   List<Exercise> exercises = [];

   if (exerciseOrder == ExerciseOrder.random) {
     vocabularies.shuffle();
   }

   switch (languageDirection) {
     case LanguageDirection.standard:
       exercises = vocabularies.map((e) {
          return Exercise._withStandardLanguageDirection(
              vocabularyCollection!.languageAName(context),
              vocabularyCollection!.languageBName(context),
              e);
        }).toList();
       break;
     case LanguageDirection.reverse:
       exercises = vocabularies.map((e) {
         return Exercise._withReverseLanguageDirection(
             vocabularyCollection!.languageAName(context),
             vocabularyCollection!.languageBName(context),
             e);
       }).toList();
       break;
     case LanguageDirection.random:
       exercises = vocabularies.map((e) {
         int n = rand(0, 2);
         if (n == 0) {
           return Exercise._withStandardLanguageDirection(
               vocabularyCollection!.languageAName(context),
               vocabularyCollection!.languageBName(context),
               e);
         } else {
           return Exercise._withReverseLanguageDirection(
               vocabularyCollection!.languageAName(context),
               vocabularyCollection!.languageBName(context),
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
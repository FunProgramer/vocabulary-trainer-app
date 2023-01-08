import 'package:flutter/material.dart';
import 'package:vocabulary_trainer_app/platform/android/home_ui.dart';
import 'package:vocabulary_trainer_app/database.dart';
import 'package:vocabulary_trainer_app/entity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase
      .databaseBuilder("app_data.db")
      .build();

  database.vocabularyCollectionDao.insertVocabularyCollection(
      VocabularyCollection(
        title: "Unit 1 (Test Collection)",
        languageA: "English",
        languageB: "German"
      )
  );

  runApp(AndroidApp(appDatabase: database));
}


import 'package:flutter/material.dart';
import 'package:vocabulary_trainer_app/platform/android/home_ui.dart';
import 'package:vocabulary_trainer_app/database.dart';
import 'package:vocabulary_trainer_app/model/vocabulary_collection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase
      .databaseBuilder("app_data.db")
      .build();

  database.vocabularyCollectionDao.insertVocabularyCollection(
      VocabularyCollection(
        "Unit 1 (Test Collection)",
        "English",
        "German"
      )
  );

  runApp(AndroidApp(appDatabase: database));
}


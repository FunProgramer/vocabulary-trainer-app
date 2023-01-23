import 'package:flutter/material.dart';
import 'package:vocabulary_trainer_app/database/database.dart';

import 'screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DatabaseInstance.appDatabase = await $FloorAppDatabase
      .databaseBuilder("app_data.db")
      .addMigrations([migration1to2])
      .build();

  runApp(const VocabularyTrainerApp());
}

class VocabularyTrainerApp extends StatelessWidget {

  const VocabularyTrainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocabulary Trainer',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }

}


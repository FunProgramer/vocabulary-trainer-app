import 'package:flutter/material.dart';
import 'package:vocabulary_trainer_app/platform/android/home_ui.dart';
import 'package:vocabulary_trainer_app/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await $FloorAppDatabase
      .databaseBuilder("app_data.db")
      .addMigrations([migration1to2])
      .build();

  runApp(AndroidApp(appDatabase: database));
}


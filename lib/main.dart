import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:vocabulary_trainer_app/database/database.dart';

import 'screens/home/home.dart';
import 'generated/l10n.dart';

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
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          title: 'Vocabulary Trainer',
          localizationsDelegates: const [
            LocaleNamesLocalizationsDelegate(),
            S.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: ThemeData(
              colorScheme: lightDynamic,
              useMaterial3: true
          ),
          darkTheme: ThemeData(
              colorScheme: darkDynamic,
              useMaterial3: true
          ),
          themeMode: ThemeMode.system,
          home: HomeScreen(),
        );
      },
    );
  }

}


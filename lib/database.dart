import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao.dart';
import 'entity.dart';

part 'database.g.dart';

@Database(version: 2, entities: [VocabularyCollection, Vocabulary])
abstract class AppDatabase extends FloorDatabase {
  VocabularyCollectionDao get vocabularyCollectionDao;
}
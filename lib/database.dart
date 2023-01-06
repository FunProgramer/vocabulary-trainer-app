import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/vocabulary_collection_dao.dart';
import 'model.dart';

part 'database.g.dart';

@Database(version: 1, entities: [VocabularyCollection])
abstract class AppDatabase extends FloorDatabase {
  VocabularyCollectionDao get vocabularyCollectionDao;
}
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao.dart';
import '../models/vocabulary.dart';
import '../models/vocabulary_collection.dart';

part 'database.g.dart';

class DatabaseInstance {
  static AppDatabase? appDatabase;

}

@Database(version: 2, entities: [VocabularyCollection, Vocabulary])
abstract class AppDatabase extends FloorDatabase {
  VocabularyCollectionDao get vocabularyCollectionDao;
  VocabularyDao get vocabularyDao;
  CompleteVocabularyCollectionDao? _completeVocabularyCollectionDao;

  CompleteVocabularyCollectionDao getCompleteVocabularyCollectionDao() {
    _completeVocabularyCollectionDao ??= CompleteVocabularyCollectionDao(this);
    return _completeVocabularyCollectionDao!;
  }
}

final migration1to2 = Migration(1, 2, (database) async {
  await database.execute('CREATE TABLE IF NOT EXISTS `Vocabulary` (`id` INTEGER, `collectionId` INTEGER, `languageA` TEXT NOT NULL, `languageARegex` TEXT NOT NULL, `languageB` TEXT NOT NULL, `languageBRegex` TEXT NOT NULL, FOREIGN KEY (`collectionId`) REFERENCES `VocabularyCollection` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
});

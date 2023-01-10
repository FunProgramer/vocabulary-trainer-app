import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao.dart';
import 'entity.dart';

part 'database.g.dart';

@Database(version: 2, entities: [VocabularyCollection, Vocabulary])
abstract class AppDatabase extends FloorDatabase {
  VocabularyCollectionDao get vocabularyCollectionDao;
  VocabularyDao get vocabularyDao;
  FullVocabularyCollectionDao? fullVocabularyCollectionDao;

  FullVocabularyCollectionDao getFullVocabularyCollectionDao() {
    fullVocabularyCollectionDao ??= FullVocabularyCollectionDao(this);
    return fullVocabularyCollectionDao!;
  }
}

final migration1to2 = Migration(1, 2, (database) async {
  await database.execute('CREATE TABLE IF NOT EXISTS `Vocabulary` (`id` INTEGER, `collectionId` INTEGER, `languageA` TEXT NOT NULL, `languageARegex` TEXT NOT NULL, `languageB` TEXT NOT NULL, `languageBRegex` TEXT NOT NULL, FOREIGN KEY (`collectionId`) REFERENCES `VocabularyCollection` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
});

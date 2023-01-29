import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';
import '../models/complete_vocabulary_collection.dart';
import '../models/vocabulary.dart';
import '../models/vocabulary_collection.dart';

@dao
abstract class VocabularyCollectionDao {
  @Query('SELECT * from VocabularyCollection')
  Future<List<VocabularyCollection>> findAllVocabularyCollections();

  @Query('SELECT * from VocabularyCollection WHERE id = :id')
  Future<VocabularyCollection?> findVocabularyCollectionById(int id);

  @insert
  Future<void> insertVocabularyCollection(
      VocabularyCollection vocabularyCollection);

  @Query("DELETE FROM VocabularyCollection WHERE id = :id")
  Future<void> deleteVocabularyCollectionById(int id);

}

@dao
abstract class VocabularyDao {
  @Query('SELECT * from Vocabulary WHERE collectionId = :collectionId')
  Future<List<Vocabulary>> findAllVocabularyByCollectionId(int collectionId);

  @insert
  Future<void> insertVocabulary(Vocabulary vocabulary);

  @Query("DELETE FROM Vocabulary WHERE collectionId = :collectionId")
  Future<void> deleteVocabulariesByCollectionId(int collectionId);

}

class CompleteVocabularyCollectionDao {
  final AppDatabase _database;
  final VocabularyCollectionDao _vocabularyCollectionDao;
  final VocabularyDao _vocabularyDao;

  CompleteVocabularyCollectionDao(this._database)
      : _vocabularyDao = _database.vocabularyDao,
        _vocabularyCollectionDao = _database.vocabularyCollectionDao;

  Future<CompleteVocabularyCollection?> findCompleteVocabularyCollectionById(
      int id) async {
    VocabularyCollection? vocabularyCollection =
        await _vocabularyCollectionDao.findVocabularyCollectionById(id);
    if (vocabularyCollection == null) return null;

    List<Vocabulary> vocabularies =
        await _vocabularyDao.findAllVocabularyByCollectionId(id);

    return CompleteVocabularyCollection(
        vocabularyCollection.title,
        vocabularyCollection.languageA,
        vocabularyCollection.languageB,
        vocabularies);
  }

  Future<void> insertCompleteVocabularyCollection(
      VocabularyCollection vocabularyCollection,
      List<Vocabulary> vocabularies) async {
    DatabaseExecutor dbExec = _database.database;
    var vocabularyCollectionMap = {
      "title": vocabularyCollection.title,
      "languageA": vocabularyCollection.languageA,
      "languageB": vocabularyCollection.languageB
    };
    int collectionID = await dbExec.insert(
        "VocabularyCollection", vocabularyCollectionMap);
    for (Vocabulary vocabulary in vocabularies) {
      vocabulary.collectionId = collectionID;
      _vocabularyDao.insertVocabulary(vocabulary);
    }
  }

  Future<void> deleteVocabularyCollectionsAndVocabulariesById(
      List<int> collectionIds) async {
    for (int collectionId in collectionIds) {
      await _vocabularyDao.deleteVocabulariesByCollectionId(collectionId);
      await _vocabularyCollectionDao
          .deleteVocabularyCollectionById(collectionId);
    }
  }
  
}
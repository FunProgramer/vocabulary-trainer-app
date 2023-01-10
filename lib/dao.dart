import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vocabulary_trainer_app/database.dart';
import 'package:vocabulary_trainer_app/entity.dart';
import 'package:vocabulary_trainer_app/model.dart';

@dao
abstract class VocabularyCollectionDao {
  @Query('SELECT * from VocabularyCollection')
  Future<List<VocabularyCollection>> findAllVocabularyCollections();

  @Query('SELECT * from VocabularyCollection WHERE id = :id')
  Future<VocabularyCollection?> findVocabularyCollectionById(int id);

  @insert
  Future<void> insertVocabularyCollection(
      VocabularyCollection vocabularyCollection);

  @delete
  Future<void> removeVocabularyCollections(
      List<VocabularyCollection> vocabularyCollections);

}

@dao
abstract class VocabularyDao {
  @Query('SELECT * from Vocabulary WHERE collectionId = :collectionId')
  Future<List<Vocabulary>> findAllVocabularyByCollectionId(int collectionId);

  @insert
  Future<void> insertVocabulary(Vocabulary vocabulary);

}

class FullVocabularyCollectionDao {
  final AppDatabase _database;
  final VocabularyCollectionDao _vocabularyCollectionDao;
  final VocabularyDao _vocabularyDao;

  FullVocabularyCollectionDao(this._database)
      : _vocabularyDao = _database.vocabularyDao,
        _vocabularyCollectionDao = _database.vocabularyCollectionDao;

  Future<FullVocabularyCollection?> findFullVocabularyCollectionById(
      int id) async {
    VocabularyCollection? vocabularyCollection =
        await _vocabularyCollectionDao.findVocabularyCollectionById(id);
    if (vocabularyCollection == null) return null;

    List<Vocabulary> vocabularies =
        await _vocabularyDao.findAllVocabularyByCollectionId(id);

    return FullVocabularyCollection(
        vocabularyCollection.title,
        vocabularyCollection.languageA,
        vocabularyCollection.languageB,
        vocabularies);
  }

  Future<void> insertFullVocabularyCollection(
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
  
}
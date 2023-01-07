import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vocabulary_trainer_app/database.dart';
import 'package:vocabulary_trainer_app/model.dart';

@dao
abstract class VocabularyCollectionDao {
  @Query('SELECT * from VocabularyCollection')
  Future<List<VocabularyCollection>> findAllVocabularyCollections();

  @insert
  Future<void> insertVocabularyCollection(VocabularyCollection vocabularyCollection);

  @delete
  Future<void> removeVocabularyCollections(List<VocabularyCollection> vocabularyCollections);

}

class ImportDao {
  final AppDatabase database;

  ImportDao(this.database);
  
  Future<void> insertFullVocabularyCollection(VocabularyCollection vocabularyCollection, List<Vocabulary> vocabularies) async {
    DatabaseExecutor dbExec = database.database;
    var vocabularyCollectionMap = {
      "title": vocabularyCollection.title,
      "languageA": vocabularyCollection.languageA,
      "languageB": vocabularyCollection.languageB
    };
    int collectionID = await dbExec.insert("VocabularyCollection", vocabularyCollectionMap);
    for (Vocabulary vocabulary in vocabularies) {
      var vocabularyMap = {
        "languageA": vocabulary.languageA,
        "languageARegex": vocabulary.languageARegex,
        "languageB": vocabulary.languageB,
        "languageBRegex": vocabulary.languageBRegex,
        "collectionId": collectionID
      };
      await dbExec.insert("Vocabulary", vocabularyMap);
    }
  }
  
}
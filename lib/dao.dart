import 'package:floor/floor.dart';
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
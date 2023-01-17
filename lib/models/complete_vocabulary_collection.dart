import 'vocabulary.dart';
import 'vocabulary_collection.dart';

class CompleteVocabularyCollection {
  final String title;
  final String languageA;
  final String languageB;
  final List<Vocabulary> vocabularies;

  CompleteVocabularyCollection(
      this.title, this.languageA, this.languageB, this.vocabularies);

  factory CompleteVocabularyCollection.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonVocabularies = json['vocabularies'];
    final List<Vocabulary> vocabularies = List.generate(jsonVocabularies.length,
            (index) => Vocabulary.fromJson(jsonVocabularies[index]));
    return CompleteVocabularyCollection(
        json['title'],
        json['languageA'],
        json['languageB'],
        vocabularies
    );
  }

  VocabularyCollection getVocabularyCollection() {
    return VocabularyCollection(
        title: title, languageA: languageA, languageB: languageB);
  }

}
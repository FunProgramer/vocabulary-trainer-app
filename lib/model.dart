/// This file contains classes (object models) that are only used inside the app (not as a database entity)

import 'entity.dart';

class FullVocabularyCollection {
  final String title;
  final String languageA;
  final String languageB;
  final List<Vocabulary> vocabularies;

  FullVocabularyCollection(
      this.title, this.languageA, this.languageB, this.vocabularies);

  factory FullVocabularyCollection.fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> jsonVocabularies = json['vocabularies'];
    final List<Vocabulary> vocabularies = List.generate(jsonVocabularies.length,
            (index) => Vocabulary.fromJson(jsonVocabularies[index]));
    return FullVocabularyCollection(
        json['title'],
        json['languageA'],
        json['LanguageB'],
        vocabularies
    );
  }

    VocabularyCollection getVocabularyCollection() {
      return VocabularyCollection(title: title, languageA: languageA, languageB: languageB);
    }

}
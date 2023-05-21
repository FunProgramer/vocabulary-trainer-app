import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

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

  languageAName(BuildContext context) {
    var name = LocaleNames.of(context)!.nameOf(languageA);
    if (name == null) {
      return languageA;
    }
    return name;
  }

  languageBName(BuildContext context) {
    var name = LocaleNames.of(context)!.nameOf(languageB);
    if (name == null) {
      return languageB;
    }
    return name;
  }

}
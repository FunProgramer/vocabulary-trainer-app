import 'package:floor/floor.dart';

@entity
class VocabularyCollection {
  @primaryKey
  int? id;

  final String title;
  final String languageA;
  final String languageB;

  VocabularyCollection(this.title, this.languageA, this.languageB, [this.id]);
}
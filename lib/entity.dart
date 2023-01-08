import 'package:floor/floor.dart';

@entity
class VocabularyCollection {
  @primaryKey
  int? id;

  final String title;
  final String languageA;
  final String languageB;

  VocabularyCollection(
      {this.id,
      required this.title,
      required this.languageA,
      required this.languageB});
}

@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ["collectionId"],
      parentColumns: ["id"],
      entity: VocabularyCollection)
])
class Vocabulary {
  @primaryKey
  int? id;

  int? collectionId;

  final String languageA;
  final String languageARegex;
  final String languageB;

  final String languageBRegex;

  Vocabulary(
      {this.id,
      this.collectionId,
      required this.languageA,
      required this.languageARegex,
      required this.languageB,
      required this.languageBRegex});
}
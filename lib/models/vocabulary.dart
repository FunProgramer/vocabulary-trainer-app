import 'package:floor/floor.dart';
import 'vocabulary_collection.dart';

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

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return Vocabulary(
        languageA: json['languageA'],
        languageARegex: json['languageARegex'],
        languageB: json['languageB'],
        languageBRegex: json['languageBRegex']
    );
  }
}
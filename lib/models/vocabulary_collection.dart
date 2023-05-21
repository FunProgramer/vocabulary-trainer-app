import 'package:floor/floor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import '../generated/l10n.dart';

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

  languageAName(BuildContext context) {
    var name = LocaleNames.of(context)!.nameOf(languageA);
    return name ?? S.of(context).unknownLanguage(languageA);
  }

  languageBName(BuildContext context) {
    var name = LocaleNames.of(context)!.nameOf(languageB);
    return name ?? S.of(context).unknownLanguage(languageB);
  }
}
import 'package:flutter/material.dart';

import '../../models/complete_vocabulary_collection.dart';
import '../../models/vocabulary.dart';

class DetailsDisplay extends StatelessWidget {
  final bool importMode;
  final CompleteVocabularyCollection vocabularyCollection;

  const DetailsDisplay(
      {Key? key, required this.vocabularyCollection, required this.importMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(children: [
              Text(
                vocabularyCollection.title,
                style: textTheme.headline3,
              ),
              Visibility(
                  visible: importMode,
                  child: Row(
                    children: const [
                      Icon(Icons.info_outline),
                      Text("Collection currently not imported."
                          " Click on 'Import' in the bar above,"
                          " to import this collection.")
                    ],
                  ),
              ),
              Row(
                children: [
                  const Icon(Icons.language),
                  Text(
                    "Languages",
                    style: textTheme.labelLarge,
                  ),
                  Expanded(child: Container()),
                  Text("${vocabularyCollection.languageA}, ${vocabularyCollection.languageB}")
                ],
              )
            ]);
          } else {
            var i = index - 1;
            Vocabulary vocabulary = vocabularyCollection.vocabularies[i];
            return Row(
              children: [
                Text(vocabulary.languageA),
                const Expanded(child: Text("-")),
                Text(vocabulary.languageB)
              ],
            );
          }
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: vocabularyCollection.vocabularies.length + 1
    );
  }
}

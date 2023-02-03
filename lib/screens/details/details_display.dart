import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:flutter/material.dart';
import 'package:sliver_table/sliver_table.dart';
import 'package:vocabulary_trainer_app/screens/details/hidable_info.dart';
import 'package:vocabulary_trainer_app/screens/details/table_elements.dart';

import '../../models/complete_vocabulary_collection.dart';

class DetailsDisplay extends StatelessWidget {
  final bool importMode;
  final CompleteVocabularyCollection vocabularyCollection;

  const DetailsDisplay(
      {Key? key, required this.vocabularyCollection, required this.importMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final windowWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          expandedHeight: 150,
          backgroundColor: theme.canvasColor,
          flexibleSpace: CustomizableSpaceBar(
            builder: (context, scrollingRate) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      vocabularyCollection.title,
                      style: TextStyle(fontSize: 50 - 18 * scrollingRate),
                    ),
                  ),
                  HidableInfo(
                    scrollingRate: scrollingRate,
                    child: Column(
                      children: [
                        Visibility(
                            visible: importMode,
                            child: Row(
                              children: const [
                                Icon(Icons.info_outline),
                                Flexible(
                                    child: Text(
                                  "Collection currently not imported."
                                  " Click on 'Import' in the bar above,"
                                  " to import this collection.",
                                  overflow: TextOverflow.clip,
                                ))
                              ],
                            )
                        ),
                        Row(
                          children: [
                            const Icon(Icons.list),
                            Text("${vocabularyCollection.vocabularies.length} Vocabularies")
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
              );
            },
          ),
        ),
        SliverTable(
            rowsCount: vocabularyCollection.vocabularies.length,
            colsCount: 2,
            cellWidth: windowWidth / 2,
            leftHeaderCellWidth: 0,
            cellBuilder: (context, row, col) {
              var vocabulary = vocabularyCollection.vocabularies[row];

              if (col == 0) {
                return TableElementA(text: vocabulary.languageA);
              } else {
                return TableElementB(text: vocabulary.languageB);
              }
            },
            topHeaderBuilder: (context, index) {
              String text;

              if (index == 0) {
                text = vocabularyCollection.languageA;
              } else {
                text = vocabularyCollection.languageB;
              }
              return TableHeader(text);
            },
            leftHeaderBuilder: (context, index) => Container()
        )
      ],
    );
  }
}

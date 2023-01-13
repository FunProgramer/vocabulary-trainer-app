import 'package:flutter/material.dart';

import '../../dao.dart';
import '../../model.dart';
import '../../entity.dart';
import '../../exception.dart';
import '../../import_util.dart' as import_util;
import 'util_ui.dart';

class CollectionDetails extends StatefulWidget {
  final bool importMode;
  final Future<FullVocabularyCollection?> futureCollection;
  final FullVocabularyCollectionDao? dao;

  const CollectionDetails._internalConstructor(
      {Key? key, required this.importMode, required this.futureCollection, this.dao})
      : super(key: key);

  factory CollectionDetails.fromDatabase(
      FullVocabularyCollectionDao dao, int collectionID) {
    var futureCollection = dao.findFullVocabularyCollectionById(collectionID);
    return CollectionDetails._internalConstructor(
        importMode: false, futureCollection: futureCollection, dao: dao);
  }

  factory CollectionDetails.fromFile() {
    var futureCollection = import_util.readVocabularyCollectionFromJSONFile();
    return CollectionDetails._internalConstructor(importMode: true, futureCollection: futureCollection);
  }

  @override
  State<CollectionDetails> createState() => _CollectionDetailsState();
}

class _CollectionDetailsState extends State<CollectionDetails> {
  bool _loading = false;
  String? _error;
  FullVocabularyCollection? _vocabularyCollection;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getData();
  }

  Future<void> _getData() async {
    try {
      FullVocabularyCollection? vocabularyCollection =
          await widget.futureCollection;
      if (vocabularyCollection == null) {
        setState(() {
          _loading = false;
          _error = "Failed to load data.";
        });
      } else {
        setState(() {
          _loading = false;
          _vocabularyCollection = vocabularyCollection;
        });
      }
    } on FilePickingAbortedException {
      Navigator.pop(context);
    } catch (e) {
      if (e.runtimeType == BrokenFileException) {
        setState(() {
          _loading = false;
          _error =
          "The provided file is not in the expected format or was corrupted.\n${e.toString()}";
        });
      }
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    Widget localWidget;
    final textTheme = Theme.of(context).textTheme;

    String text = widget.importMode ? "Import" : "Collection Details";

    if (_loading) {
      localWidget = LoadingDisplay(
          infoText: widget.importMode ? "Reading file..." : "Loading data...");
    } else if (_error != null) {
      localWidget = PlaceholderDisplay(
          icon: Icons.error_outline,
          headline: "An error occurred",
          moreInfo: _error!);
    } else {
      final vocabularyCollection = _vocabularyCollection!;
      if (widget.importMode) {
        actions.add(
            TextButton(
                onPressed: () {
              widget.dao?.insertFullVocabularyCollection(
                  vocabularyCollection.getVocabularyCollection(),
                  vocabularyCollection.vocabularies);
            },
                child: const Text("Import")
            )
        );
      }

      localWidget = ListView.separated(
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(children: [
                Text(
                  vocabularyCollection.title,
                  style: textTheme.headline3,
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

    return Scaffold(
      appBar: AppBar(
        title: Text(text),
        actions: actions,
      ),
      body: Center(child: localWidget),
    );
  }
}

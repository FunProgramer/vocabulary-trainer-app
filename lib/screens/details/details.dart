import 'package:flutter/material.dart';

import '../../components/data_fetcher.dart';
import '../../database/database.dart';
import 'details_display.dart';
import '../../database/dao.dart';
import '../../../exception.dart';
import '../../models/complete_vocabulary_collection.dart';
import '../../services/import.dart' as import_util;
import '../../components/loading_display.dart';
import '../../components/placeholder_display.dart';

class CollectionDetails extends StatefulWidget {
  final bool importMode;
  final Future<CompleteVocabularyCollection?> futureCollection;
  final CompleteVocabularyCollectionDao? dao;

  const CollectionDetails._internalConstructor(
      {Key? key,
      required this.importMode,
      required this.futureCollection,
      this.dao})
      : super(key: key);

  factory CollectionDetails.fromDatabase(int collectionID) {
    CompleteVocabularyCollectionDao dao =
        DatabaseInstance.appDatabase!.getCompleteVocabularyCollectionDao();
    var futureCollection = dao.findFullVocabularyCollectionById(collectionID);
    return CollectionDetails._internalConstructor(
        importMode: false, futureCollection: futureCollection, dao: dao);
  }

  factory CollectionDetails.fromFile() {
    var futureCollection = import_util.readVocabularyCollectionFromJSONFile();
    return CollectionDetails._internalConstructor(
        importMode: true, futureCollection: futureCollection);
  }

  @override
  State<CollectionDetails> createState() => _CollectionDetailsState();
}

class _CollectionDetailsState extends State<CollectionDetails> {
  CompleteVocabularyCollection? _vocabularyCollection;

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Collection Details"),
        actions: actions,
      ),
      body: Center(
          child: DataFetcher<CompleteVocabularyCollection>(
            loadData: () async {
              CompleteVocabularyCollection? vocabularyCollection =
                await widget.futureCollection;
              if (vocabularyCollection == null) {
                throw NoDataException();
              }
              return vocabularyCollection;
            },
            loadingWidget: LoadingDisplay(
              infoText: widget.importMode ? "Reading file..." : "Loading data...",
            ),
            onError: (exception) {
              String error = "Not available";

              if (exception is FilePickingAbortedException) {
                Navigator.pop(context);
              } else if (exception is NoDataException) {
                error = "No data found. That means usually means, "
                    "that the requested Vocabulary Collection does not exist.";
              } else if (exception is BrokenFileException) {
                error = "The provided JSON-File is not in the correct format.";
              } else {
                error = exception.toString();
              }

              return PlaceholderDisplay(
                icon: Icons.error,
                headline: "An error occurred",
                moreInfo: "More info:\n$error");
            },
            onFinished: (dynamic data) {
              return DetailsDisplay(vocabularyCollection: data, importMode: widget.importMode);
            },
        )
      ),
    );
  }
}

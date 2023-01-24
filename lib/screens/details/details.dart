import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final CompleteVocabularyCollectionDao dao;

  CollectionDetails._internalConstructor(
      {Key? key,
      required this.importMode,
      required this.futureCollection})
      : dao = DatabaseInstance.appDatabase!.getCompleteVocabularyCollectionDao(), super(key: key);

  factory CollectionDetails.fromDatabase(int collectionID) {
    CompleteVocabularyCollectionDao dao =
        DatabaseInstance.appDatabase!.getCompleteVocabularyCollectionDao();
    var futureCollection = dao.findCompleteVocabularyCollectionById(collectionID);
    return CollectionDetails._internalConstructor(
        importMode: false, futureCollection: futureCollection);
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

  Future<void> _importVocabularyCollection() async {
    if (_vocabularyCollection == null) {
      return;
    }
    BuildContext? dContext;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          dContext = context;
          return const AlertDialog(
            title: Text ("Import Vocabulary Collection"),
            content: LoadingDisplay(
              infoText: "Importing",
            ),
          );
        },
    );
    try {
      await widget.dao.insertCompleteVocabularyCollection(
              _vocabularyCollection!.getVocabularyCollection(),
              _vocabularyCollection!.vocabularies
          );
    } catch (e) {
      if (dContext != null) {
        Navigator.pop(dContext!);
      }
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(Icons.error_outline),
              title: const Text("An error occurred while trying to import"),
              content: Text("More info:\n${e.toString}"),
            );
          }
      );
    }
    // Pop Dialog
    if (dContext != null) {
      Navigator.pop(dContext!);
    }
    // Pop CollectionDetails (this widget)
    if (mounted) {
      Navigator.pop(context);
    }
    Fluttertoast.showToast(msg: "Successfully imported Vocabulary Collection");
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];

    if (_vocabularyCollection != null) {
      if (widget.importMode) {
        actions.add(IconButton(
            onPressed: _importVocabularyCollection,
            icon: const Icon(Icons.save_alt),
            tooltip: "Import Vocabulary Collection",
        ));
      }
    }

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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _vocabularyCollection = data;
            });
          });
          return DetailsDisplay(vocabularyCollection: data, importMode: widget.importMode);
            },
        )
      ),
    );
  }
}

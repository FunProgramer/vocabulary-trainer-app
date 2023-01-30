import 'package:flutter/material.dart';
import 'package:vocabulary_trainer_app/components/error_dialog.dart';
import 'package:vocabulary_trainer_app/components/loading_dialog.dart';
import 'package:vocabulary_trainer_app/screens/home/selectable_list_tile.dart';
import 'package:vocabulary_trainer_app/screens/home/selection_app_bar.dart';

import '../../components/data_fetcher.dart';
import '../../components/loading_display.dart';
import '../../database/database.dart';
import '../../exception.dart';
import '../../components/placeholder_display.dart';
import '../../database/dao.dart';
import '../../models/vocabulary_collection.dart';
import '../details/details.dart';

class HomePage extends StatefulWidget {
  final VocabularyCollectionDao collectionDao =
      DatabaseInstance.appDatabase!.vocabularyCollectionDao;
  final CompleteVocabularyCollectionDao completeCollectionDao =
      DatabaseInstance.appDatabase!.getCompleteVocabularyCollectionDao();

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<int> _selectedItems = [];
  Key dataFetcherKey = UniqueKey();

  void removeSelection() {
    setState(() {
      _selectedItems.clear();
    });
  }

  Future<void> deleteSelectedItems() async {
    if (_selectedItems.isEmpty) {
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Vocabulary Collections?"),
          content: Text("Are you sure to delete ${_selectedItems.length} "
              "Vocabulary Collection(s)?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () async {
                BuildContext? dContext;
                Navigator.pop(context);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    dContext = context;
                    return const LoadingDialog(
                        title: "Delete Vocabulary Collection",
                        infoText: "Deleting");
                  },
                );
                try {
                  await widget.completeCollectionDao
                      .deleteVocabularyCollectionsAndVocabulariesById(
                          _selectedItems);
                } catch (e) {
                  if (dContext != null) {
                    Navigator.pop(dContext!);
                  }
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ErrorDialog(
                            dialogContext: context, errorString: e.toString());
                      });
                }
                // Pop Dialog
                if (dContext != null) {
                  Navigator.pop(dContext!);
                }
                setState(() {
                  _selectedItems.clear();
                  dataFetcherKey = UniqueKey();
                });
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SelectionAppBar(
        selectionLength: _selectedItems.length,
        deleteSelectedItems: deleteSelectedItems,
        removeSelection: removeSelection
      ),
      body: Center(
          child: DataFetcher<List<VocabularyCollection>>(
            key: dataFetcherKey,
            loadData: () async {
              List<VocabularyCollection> vocabularyCollections =
                await widget.collectionDao.findAllVocabularyCollections();
              if (vocabularyCollections.isEmpty) {
                throw NoDataException();
              }
              return vocabularyCollections;
            },
            loadingWidget: const LoadingDisplay(
              infoText: "Loading data...",
            ),
            onError: (exception) {
              if (exception is NoDataException) {
                return const PlaceholderDisplay(
                    icon: Icons.list,
                    headline: "No collections",
                    moreInfo: "Click on the plus icon in the bottom right"
                        " corner to add one.");
              } else {
                return PlaceholderDisplay(
                    icon: Icons.error,
                    headline: "An error occurred",
                    moreInfo: "More info:\n${exception.toString()}");
              }
            },
            onFinished: (dynamic data) {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  VocabularyCollection collection = data[index];
                  bool selected = _selectedItems.contains(collection.id);

                  return SelectableListTile(
                      selected: _selectedItems.contains(collection.id),
                      listHasSelection: _selectedItems.isNotEmpty,
                      collection: collection,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return CollectionDetails.fromDatabase(collection.id!);
                          },
                        ));
                      },
                      selectOrDeselect: () {
                        setState(() {
                          if (selected) {
                            _selectedItems.remove(collection.id);
                          } else {
                            _selectedItems.add(collection.id!);
                          }
                        });
                      }
                  );
                },
              );
            },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? shouldRefresh = await Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return CollectionDetails.fromFile();
            },
          ));

          if (shouldRefresh != null && shouldRefresh) {
            // Force reload, by creating a new DataFetcher-Widget
            dataFetcherKey = UniqueKey();
          }

          setState(() {
            _selectedItems.clear();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

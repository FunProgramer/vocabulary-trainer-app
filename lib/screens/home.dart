import 'package:flutter/material.dart';

import '../components/data_fetcher.dart';
import '../components/loading_display.dart';
import '../database/database.dart';
import '../exception.dart';
import '../components/placeholder_display.dart';
import '../database/dao.dart';
import '../models/vocabulary_collection.dart';
import 'details/details.dart';

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

  Future<void> deleteSelectedItems() async {
    if (_selectedItems.isEmpty) {
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete Vocabulary Collections?"),
          content: Text(
              "Are you sure to delete ${_selectedItems.length} "
                  "Vocabulary Collection(s)?"
          ),
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
                    return const AlertDialog(
                      title: Text("Delete Vocabulary Collections"),
                      content: LoadingDisplay(
                        infoText: "Deleting",
                      ),
                    );
                  },
                );
                try {
                  await widget.completeCollectionDao
                      .deleteVocabularyCollectionsAndVocabulariesById(_selectedItems);
                } catch (e) {
                  if (dContext != null) {
                    Navigator.pop(dContext!);
                  }
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          icon: const Icon(Icons.error_outline),
                          title: const Text(
                              "An error occurred while trying to import"),
                          content: Text("More info:\n${e.toString()}"),
                          actions: [
                            TextButton(
                                child: const Text("Ok"),
                                onPressed: () => Navigator.pop(context))
                          ],
                        );
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
    var theme = Theme.of(context);
    List<Widget> actions = [];
    bool hasSelection = _selectedItems.isNotEmpty;

    IconButton removeSelectionButton = IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        setState(() {
          _selectedItems.clear();
        });
      },
    );

    IconButton deleteSelectedItemsButton = IconButton(
        icon: const Icon(Icons.delete), onPressed: deleteSelectedItems);

    if (hasSelection) {
      actions.add(deleteSelectedItemsButton);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(hasSelection
            ? "${_selectedItems.length} selected"
            : "Vocabulary Trainer"),
        leading: hasSelection ? removeSelectionButton : null,
        actions: actions,
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

                  CircleAvatar leadingAvatar = CircleAvatar(
                    child: Icon(selected ? Icons.check : Icons.book_outlined),
                  );

                  Function() onTap = () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return CollectionDetails.fromDatabase(collection.id!);
                      },
                    ));
                  };

                  select() {
                    setState(() {
                      if (selected) {
                        _selectedItems.remove(collection.id);
                      } else {
                        _selectedItems.add(collection.id!);
                      }
                    });
                  }

                  if (hasSelection) {
                    onTap = select;
                  }

                  return ListTile(
                    onTap: onTap,
                    onLongPress: () {
                      setState(() {
                        _selectedItems.add(collection.id!);
                      });
                    },
                    selected: selected,
                    selectedTileColor: theme.highlightColor,
                    leading: leadingAvatar,
                    title: Text(collection.title),
                    subtitle: Row(
                      children: [
                        Text(collection.languageA),
                        const Text(" - "),
                        Text(collection.languageB)
                      ],
                    ),
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

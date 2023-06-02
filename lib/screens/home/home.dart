import 'package:flutter/material.dart';

import '../../components/error_dialog.dart';
import '../../components/loading_dialog.dart';
import '../../components/loading_display.dart';
import '../../components/data_fetcher.dart';
import '../../components/placeholder_display.dart';
import '../../database/database.dart';
import '../../database/dao.dart';
import '../../exception.dart';
import '../../generated/l10n.dart';
import '../../models/vocabulary_collection.dart';

import '../details/details.dart';
import '../about.dart';

import 'selectable_list_tile.dart';
import 'selection_app_bar.dart';

class HomeScreen extends StatefulWidget {
  final VocabularyCollectionDao collectionDao =
      DatabaseInstance.appDatabase!.vocabularyCollectionDao;
  final CompleteVocabularyCollectionDao completeCollectionDao =
      DatabaseInstance.appDatabase!.getCompleteVocabularyCollectionDao();

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          title: Text(
              S.of(context).deleteVocabularyCollections(_selectedItems.length)
          ),
          content: Text(
              S.of(context).deleteVocabularyCollectionsFull(_selectedItems.length)
          ),
          actions: [
            TextButton(
              child: Text(S.of(context).no),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(S.of(context).yes),
              onPressed: () async {
                BuildContext? dContext;
                Navigator.pop(context);
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    dContext = context;
                    return LoadingDialog(
                        title: S.of(context).deletingVocabularyCollection,
                        infoText: S.of(context).deleting);
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
    var theme = Theme.of(context);

    return WillPopScope(
      onWillPop: () async {
        if (_selectedItems.isNotEmpty) {
          setState(() {
            _selectedItems.clear();
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: SelectionAppBar(
          selectionLength: _selectedItems.length,
          deleteSelectedItems: deleteSelectedItems,
          removeSelection: removeSelection,
          defaultActions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    onTap: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const AboutScreen();
                            })
                        );
                      });
                    },
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: theme.textTheme.bodySmall?.color),
                        const SizedBox(width: 8),
                        Text(S.of(context).aboutApp)
                      ],
                    ),
                  )
                ];
              },
            )
          ],
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
              loadingWidget: LoadingDisplay(
                infoText: S.of(context).loadingData,
              ),
              onError: (exception) {
                if (exception is NoDataException) {
                  return PlaceholderDisplay(
                      icon: Icons.list,
                      headline: S.of(context).noCollections,
                      moreInfo: S.of(context).addCollectionHint);
                } else {
                  return PlaceholderDisplay(
                      icon: Icons.error,
                      headline: S.of(context).anErrorOccurred,
                      moreInfo: S.of(context).moreInfoError(exception.toString()));
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
      ),
    );
  }
}

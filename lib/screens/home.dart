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
  final VocabularyCollectionDao dao =
      DatabaseInstance.appDatabase!.vocabularyCollectionDao;

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<int> _selectedItems = [];
  Key dataFetcherKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Vocabulary Trainer")),
      body: Center(
          child: DataFetcher<List<VocabularyCollection>>(
            key: dataFetcherKey,
            loadData: () async {
              List<VocabularyCollection> vocabularyCollections =
                await widget.dao.findAllVocabularyCollections();
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
                        " corner to add one."
                );
              } else {
                return PlaceholderDisplay(
                    icon: Icons.error,
                    headline: "An error occurred",
                    moreInfo: "More info:\n${exception.toString()}"
                );
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CollectionDetails.fromDatabase(collection.id!);
                          },
                        )
                    );
                  };

                  select () {
                    if (selected) {
                      setState(() {
                        _selectedItems.remove(collection.id);
                      });
                    } else {
                      setState(() {
                        _selectedItems.add(collection.id!);
                      });
                    }
                  }

                  if (_selectedItems.isNotEmpty) {
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
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool? shouldRefresh = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CollectionDetails.fromFile();
                  },
              )
          );

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

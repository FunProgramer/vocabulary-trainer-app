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
  List<VocabularyCollection>? _vocabularyCollections;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vocabulary Trainer")),
      body: Center(
          child: DataFetcher<List<VocabularyCollection>>(
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
                  var collection = data[index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) {
                                return CollectionDetails.fromDatabase(collection.id);
                              },
                          )
                      );
                    },
                    leading: const CircleAvatar(
                        child: Icon(Icons.book_outlined)
                    ),
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
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return CollectionDetails.fromFile();
                  },
              )
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

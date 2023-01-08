import 'package:flutter/material.dart';
import 'package:vocabulary_trainer_app/dao.dart';
import 'package:vocabulary_trainer_app/database.dart';
import 'package:vocabulary_trainer_app/entity.dart';

class AndroidApp extends StatelessWidget {
  final AppDatabase appDatabase;

  const AndroidApp({super.key, required this.appDatabase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocabulary Trainer',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
      ),
      themeMode: ThemeMode.system,
      home: HomePage(
        dao: appDatabase.vocabularyCollectionDao,
      ),
    );
  }

}

class HomePage extends StatefulWidget {
  final VocabularyCollectionDao dao;

  const HomePage({Key? key, required this.dao}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  String? _error;
  List<VocabularyCollection>? _vocabularyCollections;


  @override
  void initState() {
    super.initState();
    _loading = true;
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _loading = true;
    });
    try {
      _vocabularyCollections = await widget.dao.findAllVocabularyCollections();
    } catch (e) {
      _error = e.toString();
    }
    setState(() {
      _vocabularyCollections = _vocabularyCollections;
      _loading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (_error != null) {
      widget = ListPlaceholder(
              icon: Icons.error,
              headline: "An error occurred",
              moreInfo: "More info: $_error");
    }

    if (_loading && _vocabularyCollections == null) {
      widget = const ListPlaceholder();
    } else if (_vocabularyCollections == null) {
      widget = const ListPlaceholder(
              icon: Icons.error,
              headline: "An error occurred",
              moreInfo: "More info: No data present (There is no information why)");
    } else if (_vocabularyCollections!.isEmpty) {
      widget = const ListPlaceholder(
              icon: Icons.list,
              headline: "No collections",
              moreInfo: "Click on the plus icon in the bottom right corner to add one.");
    } else {
      List<VocabularyCollection> collections = _vocabularyCollections!;
      widget = ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: collections.length,
        itemBuilder: (context, index) {
          var collection = collections[index];
          return ListTile(
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
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Vocabulary Trainer"),),
      body: Center(
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: widget,
          )
      ),
    );
  }
}

class ListPlaceholder extends StatelessWidget {
  final IconData? icon;
  final String headline;
  final String moreInfo;

  const ListPlaceholder(
      {super.key,
      this.icon,
      this.headline = "",
      this.moreInfo = ""});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var windowSize = MediaQuery.of(context).size;
    // SingleChildScrollView and the physics property
    // is needed for the RefreshIndicator to work
    return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: windowSize.height - 100,
          width: windowSize.width,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icon),
            const SizedBox(height: 10),
            Text(
              headline,
              style: textTheme.headline5,
            ),
            Text(moreInfo)
          ]),
        ));
  }

}

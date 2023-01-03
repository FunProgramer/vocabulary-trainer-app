import 'package:flutter/material.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

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
      home: Scaffold(
        appBar: AppBar(title: const Text("Vocabulary Trainer"),),
        body: const Center(
          child: Text("Hello")
        ),
      ),
    );
  }

}
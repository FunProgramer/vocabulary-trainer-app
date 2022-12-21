import 'package:flutter/material.dart';
import 'package:vocabulary_trainer_app/config.dart';

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocabulary Trainer',
      theme: ThemeData(
          primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Vocabulary Trainer"),),
        body: const Center(
          child: Text("Hello")
        ),
      ),
    );
  }

}
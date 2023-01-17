import 'package:flutter/material.dart';

class LoadingDisplay extends StatelessWidget {
  final String infoText;

  const LoadingDisplay({super.key, required this.infoText});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LinearProgressIndicator(),
        Text(infoText)
      ],
    );
  }

}
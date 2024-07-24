import 'package:flutter/material.dart';

import 'loading_display.dart';

class LoadingDialog extends StatelessWidget {
  final String title;
  final String infoText;

  const LoadingDialog({super.key, required this.title, required this.infoText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: LoadingDisplay(
        infoText: infoText,
      ),
    );
  }
}

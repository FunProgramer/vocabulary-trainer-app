import 'package:flutter/material.dart';

import 'loading_display.dart';

class LoadingDialog extends StatelessWidget {
  final String title;
  final String infoText;

  const LoadingDialog({Key? key, required this.title, required this.infoText})
      : super(key: key);

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

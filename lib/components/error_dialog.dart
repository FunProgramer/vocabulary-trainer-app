import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final BuildContext dialogContext;
  final String errorString;

  const ErrorDialog(
      {Key? key, required this.dialogContext, required this.errorString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.error_outline),
      title: const Text("An error occurred"),
      content: Text("More info:\n$errorString"),
      actions: [
        TextButton(
            child: const Text("Ok"),
            onPressed: () => Navigator.pop(dialogContext))
      ],
    );
  }
}

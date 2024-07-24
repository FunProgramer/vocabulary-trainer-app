import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class ErrorDialog extends StatelessWidget {
  final BuildContext dialogContext;
  final String errorString;

  const ErrorDialog(
      {super.key, required this.dialogContext, required this.errorString});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.error_outline),
      title: Text(S.of(context).anErrorOccurred),
      content: Text(S.of(context).moreInfoError(errorString)),
      actions: [
        TextButton(
            child: Text(MaterialLocalizations.of(context).okButtonLabel),
            onPressed: () => Navigator.pop(dialogContext))
      ],
    );
  }
}

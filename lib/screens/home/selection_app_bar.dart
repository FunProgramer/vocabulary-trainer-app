import 'package:flutter/material.dart';

class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectionLength;
  final Function() removeSelection;
  final Function() deleteSelectedItems;

  const SelectionAppBar(
      {Key? key,
      required this.selectionLength,
      required this.deleteSelectedItems,
      required this.removeSelection})
      : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    bool hasSelection = selectionLength != 0;
    List<Widget> actions = [];

    IconButton removeSelectionButton = IconButton(
        icon: const Icon(Icons.arrow_back), onPressed: removeSelection);

    IconButton deleteSelectedItemsButton = IconButton(
        icon: const Icon(Icons.delete), onPressed: deleteSelectedItems);

    if (hasSelection) {
      actions.add(deleteSelectedItemsButton);
    }

    return AppBar(
      title: Text(
          hasSelection ? "$selectionLength selected" : "Vocabulary Trainer"),
      leading: hasSelection ? removeSelectionButton : null,
      actions: actions,
    );
  }
}

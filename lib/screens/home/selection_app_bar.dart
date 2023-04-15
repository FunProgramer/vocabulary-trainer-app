import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class SelectionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectionLength;
  final Function() removeSelection;
  final Function() deleteSelectedItems;
  final List<Widget> defaultActions;

  const SelectionAppBar(
      {Key? key,
      required this.selectionLength,
      required this.deleteSelectedItems,
      required this.removeSelection,
      required this.defaultActions})
      : super(key: key);

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    bool hasSelection = selectionLength != 0;

    IconButton removeSelectionButton = IconButton(
        icon: const Icon(Icons.arrow_back), onPressed: removeSelection);

    IconButton deleteSelectedItemsButton = IconButton(
        icon: const Icon(Icons.delete), onPressed: deleteSelectedItems);

    return AppBar(
      title: Text(hasSelection ? S.of(context).selectionInfo(selectionLength)
          : "Vocabulary Trainer"),
      leading: hasSelection ? removeSelectionButton : null,
      actions: hasSelection ? [deleteSelectedItemsButton] : defaultActions,
    );
  }
}

import 'package:flutter/material.dart';

import '../../models/vocabulary_collection.dart';

class SelectableListTile extends StatelessWidget {
  final VocabularyCollection collection;
  final bool listHasSelection;
  final bool selected;
  final Function() onTap;
  final Function() selectOrDeselect;

  const SelectableListTile(
      {Key? key,
      required this.selected,
      required this.onTap,
      required this.listHasSelection,
      required this.collection,
      required this.selectOrDeselect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Function() internOnTap = onTap;

    CircleAvatar leadingAvatar = CircleAvatar(
      child: Icon(selected ? Icons.check : Icons.book_outlined),
    );

    if (listHasSelection) {
      internOnTap = selectOrDeselect;
    }

    return ListTile(
      onTap: internOnTap,
      onLongPress: selectOrDeselect,
      selected: selected,
      selectedTileColor: theme.highlightColor,
      leading: leadingAvatar,
      title: Text(collection.title),
      subtitle: Row(
        children: [
          Text(collection.languageAName(context)),
          const Text(" - "),
          Text(collection.languageBName(context))
        ],
      ),
    );
  }
}

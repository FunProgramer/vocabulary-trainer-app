import 'package:flutter/material.dart';

class OptionSelectionPage<T> extends StatelessWidget {
  final Function(T?) optionSelected;
  final String question;
  final List<SelectableOption<T>> options;
  final T? selectedOption;

  const OptionSelectionPage(
      {super.key,
        required this.optionSelected,
        required this.options,
        required this.selectedOption,
        required this.question});

  @override
  Widget build(BuildContext context) {
    List<Widget> optionListTiles = [];

    for (SelectableOption option in options) {
      optionListTiles.add(RadioListTile<T>(
        title: Text(option.name),
        value: option.option,
        groupValue: selectedOption,
        onChanged: optionSelected,
      ));
    }

    return Column(
      children: [
        Text(question),
        Column(
          children: optionListTiles,
        ),
      ],
    );
  }
}

class SelectableOption<T> {
  final String name;
  final T option;

  SelectableOption(this.name, this.option);
}
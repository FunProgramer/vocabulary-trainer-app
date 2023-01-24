import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  final String text;

  const TableHeader(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.canvasColor,
        border: Border(bottom: BorderSide(color: theme.primaryColor, width: 5)),
      ),
      child: Center(
        child: Text(
          text,
          style: theme.textTheme.headlineSmall,
        ),
      ),
    );
  }
}

class TableElementA extends StatelessWidget {
  final String text;

  const TableElementA({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text
      ),
    );
  }
}

class TableElementB extends StatelessWidget {
  final String text;

  const TableElementB({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
          text,
          textAlign: TextAlign.right,
      ),
    );
  }
}


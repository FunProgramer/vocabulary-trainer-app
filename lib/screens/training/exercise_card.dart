import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final Color? color;
  final List<Widget> children;

  const ExerciseCard({super.key, this.color, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        )
      ),
    );
  }
}

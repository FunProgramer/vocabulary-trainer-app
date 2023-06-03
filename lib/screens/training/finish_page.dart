import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../services/training.dart';

class FinishPage extends StatefulWidget {
  final Training training;

  const FinishPage({super.key, required this.training});

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                    S.of(context).trainingFinished,
                    style: textTheme.headlineMedium
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

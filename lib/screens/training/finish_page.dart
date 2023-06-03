import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../services/training.dart';

class FinishPage extends StatelessWidget {
  final Training training;

  const FinishPage({super.key, required this.training});

  List<ListTile> generateListTiles(BuildContext context,
      List<Exercise> exercises, bool showCorrectAnswers) {
    List<ListTile> listTiles = [];
    for (Exercise exercise in exercises) {
      listTiles.add(ListTile(
        title: Text(exercise.toString()),
        subtitle: showCorrectAnswers
            ? Text(S.of(context).correctAnswer(exercise.requestedLanguage))
            : null,
      ));
    }
    return listTiles;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    double radius = 70;

    var correctAnsweredExercises = training.getCorrectAnsweredExercises();
    var wrongAnsweredExercises = training.getWrongAnsweredExercises();
    var skippedExercises = training.getSkippedExercises();

    var numberCorrectAnswered = correctAnsweredExercises.length;
    var numberWrongAnswered = wrongAnsweredExercises.length;
    var numberSkipped = skippedExercises.length;

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
                SizedBox(
                  width: 100,
                  height: 200,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                            centerSpaceRadius: 40,
                            sections: [
                              PieChartSectionData(
                                value: numberCorrectAnswered.toDouble(),
                                color: Colors.green,
                                radius: radius,
                                title: S.of(context).correctAnswered
                              ),
                              PieChartSectionData(
                                value: numberWrongAnswered.toDouble(),
                                color: theme.colorScheme.error,
                                radius: radius,
                                title: S.of(context).wrongAnswered
                              ),
                              PieChartSectionData(
                                value: numberSkipped
                                    .toDouble(),
                                color: Colors.grey,
                                radius: radius,
                                title: S.of(context).skipped
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                ExpansionTile(
                  leading: const Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                  title: Text(S.of(context)
                      .numberCorrectAnswered(numberCorrectAnswered)),
                    children: generateListTiles(
                        context, correctAnsweredExercises, false)
                ),
                ExpansionTile(
                    leading: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    title: Text(S.of(context)
                        .numberWrongAnswered(numberWrongAnswered)),
                    children: generateListTiles(
                        context, wrongAnsweredExercises, true)
                ),
                ExpansionTile(
                    leading: const Icon(
                      Icons.redo,
                      color: Colors.grey,
                    ),
                    title: Text(S.of(context)
                        .numberSkipped(numberSkipped)),
                    children: generateListTiles(
                        context, skippedExercises, true)
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

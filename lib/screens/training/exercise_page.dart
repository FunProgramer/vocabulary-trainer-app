import 'package:flutter/material.dart';
import 'package:vocabulary_trainer_app/models/exercise_state.dart';
import 'package:vocabulary_trainer_app/screens/training/exercise_card.dart';

import '../../services/training.dart';

class ExercisePage extends StatefulWidget {
  final Function(String answer) onSubmit;
  final Function() onSkip;
  final Function() onNextPageRequested;

  final Exercise exercise;

  const ExercisePage(
      {Key? key,
      required this.onSubmit,
      required this.onSkip,
      required this.onNextPageRequested,
      required this.exercise})
      : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  String _answer = "";

  void submit() {
    if (_answer == "") return;
    widget.onSubmit(_answer);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomActions = [];

    if (widget.exercise.state == ExerciseState.notAnswered) {
      bottomActions.addAll([
        TextButton(
          onPressed: widget.onSkip,
          child: const Text("Skip"),
        ),
        ElevatedButton(
          onPressed: submit,
          child: const Text("Submit"),
        ),
      ]);
    } else {
      bottomActions.add(ElevatedButton(
          onPressed: widget.onNextPageRequested,
          child: const Text("Next"))
      );
    }

    Widget? alertCard;

    switch (widget.exercise.state) {
      case ExerciseState.notAnswered:
        break;
      case ExerciseState.skipped:
        alertCard = ExerciseCard(
          color: Colors.grey,
          children: [
            Row(
              children: const [
                Icon(Icons.info),
                Text(
                  "You skipped this exercise.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Text("Correct answer: ${widget.exercise.requestedLanguage}")
          ]
        );
        break;
      case ExerciseState.correctAnswered:
        alertCard = ExerciseCard(
          color: Colors.green,
          children: [
            Row(
              children: const [
                Icon(Icons.check_circle),
                Text(
                  "Correct answer!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Text("Original answer: ${widget.exercise.requestedLanguage}")
          ],
        );
        break;
      case ExerciseState.wrongAnswered:
        alertCard = ExerciseCard(
            color: Theme.of(context).colorScheme.error,
            children: [
              Row(
                children: const [
                  Icon(Icons.cancel),
                  Text(
                    "Wrong answer!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Text("Correct answer: ${widget.exercise.requestedLanguage}")
            ]
        );
    }

    var textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ExerciseCard(
                    children: [
                      Text(widget.exercise.providedLanguageName),
                      Text(
                        widget.exercise.providedLanguage,
                        style: textTheme.titleLarge,
                      )
                    ]
                ),
                ExerciseCard(
                  children: [
                    Text(widget.exercise.requestedLanguageName),
                    TextField(
                      autofocus: true,
                      enabled: widget.exercise.state
                          == ExerciseState.notAnswered,
                      controller: TextEditingController(
                          text: widget.exercise.answer),
                      onChanged: (value) {
                        _answer = value;
                      },
                      onSubmitted: (value) {
                        submit();
                      },
                      style: textTheme.titleLarge,
                    )
                  ]
                ),
                Builder(
                  builder: (context) {
                    if (alertCard != null) {
                      return alertCard;
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
        ButtonBar(
          children: bottomActions,
        )
      ],
    );
  }
}

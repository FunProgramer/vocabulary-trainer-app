import 'package:flutter/material.dart';
import 'package:vocabulary_trainer_app/models/exercise_state.dart';

import '../../services/training.dart';

class ExercisePage extends StatefulWidget {
  final Function(String answer) submit;
  final Function() skip;
  final Function() nextPage;

  final ExerciseState state;
  final Exercise exercise;
  final String initialAnswer;

  const ExercisePage(
      {Key? key,
      required this.submit,
      required this.nextPage,
      required this.skip,
      required this.state,
      required this.exercise,
      required this.initialAnswer})
      : super(key: key);

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  String _answer = "";

  void submit() {
    if (_answer == "") return;
    widget.submit(_answer);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomActions = [];

    if (widget.state == ExerciseState.notAnswered) {
      bottomActions.addAll([
        TextButton(
          onPressed: widget.skip,
          child: const Text("Skip"),
        ),
        ElevatedButton(
          onPressed: submit,
          child: const Text("Submit"),
        ),
      ]);
    } else {
      bottomActions.add(ElevatedButton(
          onPressed: widget.nextPage, child: const Text("Next")));
    }

    Card? alertCard;

    switch (widget.state) {
      case ExerciseState.notAnswered:
        break;
      case ExerciseState.skipped:
        alertCard = Card(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
              ],
            ),
          ),
        );
        break;
      case ExerciseState.correctAnswered:
        alertCard = Card(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
          ),
        );
        break;
      case ExerciseState.wrongAnswered:
        alertCard = Card(
          color: Theme.of(context).colorScheme.error,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
              ],
            ),
          ),
        );
    }

    var textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.exercise.providedLanguageName),
                            Text(
                              widget.exercise.providedLanguage,
                              style: textTheme.titleLarge,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.exercise.requestedLanguageName),
                          TextField(
                            autofocus: true,
                            enabled: widget.state == ExerciseState.notAnswered,
                            controller: TextEditingController(
                                text: widget.initialAnswer),
                            onChanged: (value) {
                              _answer = value;
                            },
                            onSubmitted: (value) {
                              submit();
                            },
                            style: textTheme.titleLarge,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(
                    builder: (context) {
                      if (alertCard != null) {
                        return alertCard;
                      }

                      return Container();
                    },
                  ),
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

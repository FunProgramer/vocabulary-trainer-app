import 'package:flutter/material.dart';
import 'package:vocabulary_trainer_app/screens/training/finish_page.dart';

import '../../generated/l10n.dart';
import '../../models/exercise_state.dart';
import '../../services/training.dart';
import 'exercise_page.dart';

class TrainingScreen extends StatefulWidget {
  final Training training;

  const TrainingScreen({super.key, required this.training});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  void goToNextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [];
    int finishedExercises = widget.training.getNumberOfFinishedExercises();

    var exercises = widget.training.exercises;
    for (int i = 0; i < exercises.length; i++) {
      // Stop adding pages if the last exercise was not answered
      if (i > 0 && exercises[i-1].state == ExerciseState.notAnswered) {
        break;
      }
      Exercise exercise = exercises[i];
      pages.add(ExercisePage(
        onSubmit: (answer) {
          setState(() {
            exercise.checkAnswer(answer);
          });
        },
        onNextPageRequested: goToNextPage,
        onSkip: () {
          setState(() {
            exercise.state = ExerciseState.skipped;
          });
        },
        exercise: exercise
      ));
    }

    if (finishedExercises == exercises.length) {
      pages.add(FinishPage(training: widget.training));
    }

    return WillPopScope(
      onWillPop: () async {
        if (finishedExercises != exercises.length) {
          return await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(S.of(context).cancelTraining),
                  content: Text(S.of(context).cancelTrainingDescription),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: Text(
                          MaterialLocalizations.of(context).cancelButtonLabel
                        )
                    ),
                    FilledButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text(S.of(context).yes)
                    )
                  ],
                );
              }
          );
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).trainingTitle(widget.training.collectionTitle)),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: finishedExercises/exercises.length
                      ),
                    ),
                  ),
                  Text("$finishedExercises/${exercises.length}")
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                children: pages,
                onPageChanged: (value) {
                  if (value < finishedExercises) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

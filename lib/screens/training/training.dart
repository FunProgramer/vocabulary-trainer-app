import 'package:flutter/material.dart';

import '../../models/exercise_state.dart';
import '../../services/training.dart';
import 'exercise_page.dart';

class TrainingScreen extends StatefulWidget {
  final Training training;

  const TrainingScreen({Key? key, required this.training}) : super(key: key);

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  final PageController pageController = PageController();
  final List<ExerciseState> states = [];
  final List<String> answers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.training.exercises.length; i++) {
      states.add(ExerciseState.notAnswered);
      answers.add("");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ExercisePage> pages = [];
    int finishedExercises = -1;

    for (int i = 0; i < widget.training.exercises.length; i++) {
      if (i > 0 && states[i-1] == ExerciseState.notAnswered) {
        break;
      }
      Exercise exercise = widget.training.exercises[i];
      pages.add(ExercisePage(
        submit: (answer) {
          setState(() {
            answers[i] = answer;
            if (exercise.checkAnswer(answer)) {
              states[i] = ExerciseState.correctAnswered;
            } else {
              states[i] = ExerciseState.wrongAnswered;
            }
          });
        },
        nextPage: () {
          pageController.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        },
        skip: () {
          setState(() {
            states[i] = ExerciseState.skipped;
          });
          pageController.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        },
        state: states[i],
        exercise: exercise,
        initialAnswer: answers[i],
      ));
      finishedExercises++;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Training: ${widget.training.collectionTitle}"),
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
                      value: finishedExercises/widget.training.exercises.length
                    ),
                  ),
                ),
                Text("$finishedExercises/${widget.training.exercises.length}")
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: pages,
            ),
          )
        ],
      ),
    );
  }
}

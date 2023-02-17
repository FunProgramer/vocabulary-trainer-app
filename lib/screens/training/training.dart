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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ExercisePage> pages = [];
    int finishedExercises = -1;

    var exercises = widget.training.exercises;
    for (int i = 0; i < exercises.length; i++) {
      if (i > 0 && exercises[i-1].state == ExerciseState.notAnswered) {
        break;
      }
      Exercise exercise = exercises[i];
      pages.add(ExercisePage(
        submit: (answer) {
          setState(() {
            exercise.answer = answer;
            if (exercise.checkAnswer(answer)) {
              exercise.state = ExerciseState.correctAnswered;
            } else {
              exercise.state = ExerciseState.wrongAnswered;
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
            exercise.state = ExerciseState.skipped;
          });
          pageController.nextPage(
              duration: const Duration(milliseconds: 200),
              curve: Curves.linear);
        },
        state: exercise.state,
        exercise: exercise,
        initialAnswer: exercise.answer,
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
            ),
          )
        ],
      ),
    );
  }
}

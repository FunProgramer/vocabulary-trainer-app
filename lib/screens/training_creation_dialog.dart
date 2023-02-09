import 'package:flutter/material.dart';
import 'package:vocabulary_trainer_app/components/option_selection_page.dart';
import 'package:vocabulary_trainer_app/screens/training/training.dart';
import 'package:vocabulary_trainer_app/services/training.dart';

class TrainingCreationDialog extends StatefulWidget {
  final TrainingBuilder trainingBuilder;

  const TrainingCreationDialog({Key? key, required this.trainingBuilder})
      : super(key: key);

  @override
  State<TrainingCreationDialog> createState() => _TrainingCreationDialogState();
}

class _TrainingCreationDialogState extends State<TrainingCreationDialog> {
  final PageController pageController = PageController();
  final List<TrainingCreationOption?> selectedOptions = List.filled(2, null);
  int page = 0;

  @override
  Widget build(BuildContext context) {
    var collection = widget.trainingBuilder.vocabularyCollection!;
    List<Widget> actions = [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Cancel"),
      ),
    ];

    var pages = [
      OptionSelectionPage<LanguageDirection>(
        optionSelected: (value) {
          setState(() {
            selectedOptions[0] = value;
          });
          if (value == null) return;
          widget.trainingBuilder.languageDirection = value;
        },
        question: "In which language direction do you want to learn the vocabulary?",
        options: [
          SelectableOption<LanguageDirection>(
              "${collection.languageA} → ${collection.languageB}",
              LanguageDirection.standard),
          SelectableOption(
              "${collection.languageB} → ${collection.languageA}",
              LanguageDirection.reverse),
          SelectableOption(
              "Random for each vocabulary",
              LanguageDirection.random),
        ],
        selectedOption: selectedOptions[0] as LanguageDirection?,
      ),
      OptionSelectionPage<ExerciseOrder>(
        optionSelected: (value) {
          setState(() {
            selectedOptions[1] = value;
          });
          if (value == null) return;
          widget.trainingBuilder.exerciseOrder = value;
        },
        question: "In which order to you want to learn the vocabulary?",
        options: [
          SelectableOption<ExerciseOrder>(
              "Standard order",
              ExerciseOrder.standard),
          SelectableOption(
              "Random order",
              ExerciseOrder.random),
        ],
        selectedOption: selectedOptions[1] as ExerciseOrder?,
      )
    ];

    if (page != 0) {
      actions.add(TextButton(
          onPressed: () {
            pageController.previousPage(
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
          },
          child: const Text("Back")
      ));
    }

    // If we are on the last page
    if (page == pages.length - 1) {
      actions.add(TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TrainingScreen(training: widget.trainingBuilder.build());
          },));
        },
        child: const Text("Start training"),
      ));
    } else {
      actions.add(TextButton(
        onPressed: selectedOptions[page] == null
            ? null
            : () {
                pageController.nextPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
        child: const Text("Next"),
      ));
    }

    return AlertDialog(
      title: const Text("Learn vocabularies"),
      content: SizedBox(
        width: 300,
        height: 250,
        child: PageView( // PageView in dialog is not working
          controller: pageController,
          children: pages,
          onPageChanged: (value) {
            setState(() {
              page = value;
            });
          },
        ),
      ),
      actions: actions,
    );
  }
}


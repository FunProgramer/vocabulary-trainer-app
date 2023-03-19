import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_trainer_app/services/url_open.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("About this app"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("icon/rounded_icon.png", width: 150),
                ),
                Text("Vocabulary Trainer", style: textTheme.headlineMedium),
                Text(
                  "An app to learn vocabularies, developed with flutter.",
                  style: textTheme.bodyLarge,
                ),
                const Text("Created by FunProgramer"),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    const uriText = "https://github.com/FunProgramer/vocabulary-trainer-app";
                    bool opened = await openUrl(context, uriText);
                    if (!opened) {
                      final snackBar = SnackBar(
                        content: const Text(
                            "Couldn't to open the GitHub Website."),
                        action: SnackBarAction(
                          label: "Copy URL",
                          onPressed: () async {
                            await Clipboard.setData(
                                const ClipboardData(text: uriText));
                          },
                        ),
                      );

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  icon: const Icon(Icons.code),
                  label: const Text("Source Code"),
                )
              ]
          )
        ),
      ),
    );
  }
}

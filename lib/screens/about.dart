import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vocabulary_trainer_app/services/url_open.dart';

import '../generated/l10n.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).aboutApp),
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
                  S.of(context).appDescription,
                  style: textTheme.bodyLarge,
                  textAlign: TextAlign.center
                ),
                Text(S.of(context).author),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    const uriText = "https://github.com/FunProgramer/vocabulary-trainer-app";
                    bool opened = await openUrl(context, uriText);
                    if (!opened) {
                      if (context.mounted) {
                      final snackBar = SnackBar(
                        content: Text(S.of(context).errorOpenGitHub),
                        action: SnackBarAction(
                          label: S.of(context).copyUrl,
                          onPressed: () async {
                            await Clipboard.setData(
                                const ClipboardData(text: uriText));
                          },
                        ),
                      );
                      
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  icon: const Icon(Icons.code),
                  label: Text(S.of(context).sourceCode),
                )
              ]
          )
        ),
      ),
    );
  }
}

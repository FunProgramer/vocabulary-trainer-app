import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as ct;

Future<bool> openUrl(BuildContext context, String urlText) async {
  if (Platform.isAndroid || Platform.isMacOS) {
    try {
      await ct.launch(
        urlText,
        customTabsOption: ct.CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
        ),
        safariVCOption: ct.SafariViewControllerOption(
          preferredBarTintColor: Theme.of(context).primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: ct.SafariViewControllerDismissButtonStyle.close,
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  } else {
    Uri url = Uri.parse(urlText);
    return await launchUrl(url);
  }
}
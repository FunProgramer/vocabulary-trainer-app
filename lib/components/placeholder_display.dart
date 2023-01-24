import 'package:flutter/material.dart';

class PlaceholderDisplay extends StatelessWidget {
  final IconData? icon;
  final String headline;
  final String moreInfo;

  const PlaceholderDisplay(
      {super.key, this.icon, required this.headline, required this.moreInfo});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    var windowSize = MediaQuery.of(context).size;
    return SizedBox(
      height: windowSize.height - 100,
      width: windowSize.width,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(icon),
        const SizedBox(height: 10),
        Text(
          headline,
          style: textTheme.headline5,
        ),
        Text(
            moreInfo,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }

}
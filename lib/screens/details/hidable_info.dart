import 'package:flutter/material.dart';

class HidableInfo extends StatelessWidget {
  final double scrollingRate;
  final Widget child;

  const HidableInfo(
      {super.key, required this.child, required this.scrollingRate});

  @override
  Widget build(BuildContext context) {
    if (scrollingRate == 1) {
      return Container();
    }

    return Opacity(
          opacity: 1 - scrollingRate,
          child: child,
    );
  }
}

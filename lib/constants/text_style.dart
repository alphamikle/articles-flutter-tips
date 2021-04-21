import 'package:flutter/material.dart';

abstract class TextStyl {
  static TextStyle bold(BuildContext context) {
    return Theme.of(context).textTheme.headline5 ??
        const DefaultTextStyle.fallback().style;
  }
}

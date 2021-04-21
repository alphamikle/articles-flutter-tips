import 'package:flutter/widgets.dart';

import '../constants/padding.dart';
import 'vertical_divider.dart';

class HDivider extends StatelessWidget {
  const HDivider({
    Key? key,
    this.level = DividerLevel.l1,
  }) : super(key: key);

  final DividerLevel level;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: Pad.l1 * LEVEL_TO_INT[level]!);
  }
}

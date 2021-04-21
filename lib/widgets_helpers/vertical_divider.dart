import 'package:flutter/widgets.dart';

import '../constants/padding.dart';

enum DividerLevel { l1, l2, l3, l4, l5 }

const LEVEL_TO_INT = {
  DividerLevel.l1: 1,
  DividerLevel.l2: 2,
  DividerLevel.l3: 3,
  DividerLevel.l4: 4,
  DividerLevel.l5: 5,
};

class VDivider extends StatelessWidget {
  const VDivider({
    Key? key,
    this.level = DividerLevel.l1,
  }) : super(key: key);

  final DividerLevel level;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: Pad.l1 * LEVEL_TO_INT[level]!);
  }
}

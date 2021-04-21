import 'package:anitex/anitex.dart';
import 'package:flutter/widgets.dart';

import '../../constants/text_style.dart';
import '../../utils/utils.dart';

class MoneyRow extends StatelessWidget {
  const MoneyRow({
    required this.title,
    required this.money,
    Key? key,
  }) : super(key: key);

  final String title;
  final num money;

  /// We move all UI logic from
  /// old place (OrderView) to here
  /// and in OrderView you can use simple
  /// and small widget MoneyRow instead
  /// this several widgets
  ///
  /// And also you can reuse this in any place
  /// of your app
  @override
  Widget build(BuildContext context) {
    final infoStyle = TextStyl.bold(context);

    return Row(
      children: [
        Text(
          title,
          style: infoStyle,
        ),
        AnimatedText(
          Utils.formatMoney(money),
          style: infoStyle.copyWith(fontWeight: FontWeight.bold),
          useOpacity: false,
        ),
      ],
    );
  }
}

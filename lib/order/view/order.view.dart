import 'package:anitex/anitex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tipsalc/order/view/money_row.dart';

import '../../constants/input.dart';
import '../../constants/padding.dart';
import '../../constants/text_style.dart';
import '../../locale/locale.dart';
import '../../utils/formatters.dart';
import '../../utils/utils.dart';
import '../../widgets_helpers/horizontal_divider.dart';
import '../../widgets_helpers/vertical_divider.dart';
import '../state/order.state.dart';

class OrderView extends StatefulWidget {
  const OrderView({
    Key? key,
  }) : super(key: key);

  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  /// We will use Flutter 2.0 with Dart 2.12
  /// which offer you null-safety
  late OrderState orderState;

  @override
  void initState() {
    super.initState();

    /// For state management we will
    /// use simple [setState] method
    /// But to prevent placing business logic
    /// in UI layer - we will take out it in
    /// separate class [OrderState]
    orderState = OrderState()
      ..registerHook(() {
        /// We pass method [setState] to our
        /// OrdersState class, where this method
        /// will called after any data updates
        setState(() {});
      })
      ..initState();
  }

  @override
  void dispose() {
    orderState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final infoStyle = TextStyl.bold(context);

    return Padding(
      padding: const EdgeInsets.all(Pad.l1),
      child: Column(
        children: [
          /// This is first field with
          /// amount of just order
          TextFormField(
            decoration: InputDec.outline8.copyWith(
              labelText: Locale.billTotalLabel,
            ),
            keyboardType: TextInputType.number,
            controller: orderState.billTotalController,
            inputFormatters: [
              /// We will using formatter
              /// for prevent input non-digit symbols
              /// in our input
              NumberFormatter(),
            ],
          ),
          const VDivider(),

          /// Second field with amount of tips
          /// in percents
          TextFormField(
            decoration: InputDec.outline8.copyWith(
              labelText: Locale.tipPercentLabel,
            ),
            keyboardType: TextInputType.number,
            controller: orderState.tipAmountController,
            inputFormatters: [
              NumberFormatter(int: true),
            ],
          ),
          const VDivider(level: DividerLevel.l2),

          /// This is two ours text lines with
          /// total amount of tips in dollars
          Row(
            children: [
              Text(
                Locale.tipAmountTitle,
                style: infoStyle,
              ),
              AnimatedText(
                Utils.formatMoney(orderState.order.tipAmount),
                style: infoStyle.copyWith(fontWeight: FontWeight.bold),
                useOpacity: false,
              ),
            ],
          ),
          const VDivider(),

          /// And the second row with total amount
          /// of all order (just order + tips in dollars)
          MoneyRow(
            title: Locale.totalAmountTitle,
            money: orderState.order.totalWithTipAmount,
          ),

          /// Well, there we have a visual helper to manipulate
          /// tips quantity - you can simple increase or reduce
          /// the amount of tips with step in 5%
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Locale.changeTipHint, style: TextStyl.bold(context)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: orderState.increaseTip,
                        color: Colors.green,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.green.withOpacity(0.15),
                      ),
                      const HDivider(),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: orderState.reduceTip,
                        color: Colors.red,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.red.withOpacity(0.15),
                      ),
                    ],
                  ),
                  const VDivider(level: DividerLevel.l5),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

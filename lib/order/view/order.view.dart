import 'package:anitex/anitex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
  late OrderState orderState;

  @override
  void initState() {
    super.initState();
    orderState = OrderState()
      ..registerHook(() {
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
          TextFormField(
            decoration: InputDec.outline8.copyWith(
              labelText: Locale.billTotalLabel,
            ),
            keyboardType: TextInputType.number,
            controller: orderState.billTotalController,
            inputFormatters: [
              NumberFormatter(),
            ],
          ),
          const VDivider(),
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
          Row(
            children: [
              Text(
                Locale.totalAmountTitle,
                style: infoStyle,
              ),
              AnimatedText(
                Utils.formatMoney(orderState.order.totalWithTipAmount),
                style: infoStyle.copyWith(fontWeight: FontWeight.bold),
                useOpacity: false,
              ),
            ],
          ),
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

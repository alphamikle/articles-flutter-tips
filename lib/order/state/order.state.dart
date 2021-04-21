import 'package:flutter/widgets.dart';

import '../../utils/base_state.dart';
import '../model/order.model.dart';

const int TIP_INCREASE_STEP = 5;

class OrderState extends BaseState {
  final TextEditingController billTotalController = TextEditingController();
  final TextEditingController tipAmountController = TextEditingController();
  Order order = Order(total: 0, tipPercent: 0);

  void calculateTotals() {
    final total = double.tryParse(billTotalController.text) ?? order.total;
    final tipPercent =
        int.tryParse(tipAmountController.text) ?? order.tipPercent;
    order = order.copyWith(total: total, tipPercent: tipPercent);
  }

  void increaseTip() {
    final prevTip = order.tipPercent;
    final remainder = prevTip % TIP_INCREASE_STEP;
    final tipPercent = prevTip + (TIP_INCREASE_STEP - remainder);
    _diffTip(tipPercent);
  }

  void reduceTip() {
    final prevTip = order.tipPercent;
    final remainder = prevTip % TIP_INCREASE_STEP;
    final diff = remainder == 0 ? TIP_INCREASE_STEP : remainder;
    final tipPercent = prevTip - diff;
    _diffTip(tipPercent);
  }

  void _diffTip(int tipPercent) {
    order = order.copyWith(tipPercent: tipPercent);
    final text = order.tipPercent == 0 ? '' : order.tipPercent.toString();
    tipAmountController.value = TextEditingValue(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(
          offset: text.length,
          affinity: TextAffinity.downstream,
        ),
      ),
    );
  }

  @override
  List<VoidCallback> get hooks => [
        calculateTotals,
        ..._hooks,
      ];

  final List<VoidCallback> _hooks = [];

  @override
  void initState() {
    addListenersTo(billTotalController);
    addListenersTo(tipAmountController);
  }

  @override
  void registerHook(VoidCallback callback) {
    _hooks.add(callback);
  }

  @override
  void dispose() {
    removeListenersFrom(billTotalController);
    removeListenersFrom(tipAmountController);
  }
}

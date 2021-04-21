import 'package:flutter/cupertino.dart';

import '../../utils/utils.dart';

const int MAX_TIP_VALUE = 100;
const int MIN_VALUE = 0;

@immutable
class Order {
  factory Order({
    required double total,
    required int tipPercent,
  }) {
    return Order._(
      total: Utils.greater(total, MIN_VALUE),
      tipPercent: Utils.greater(tipPercent, MIN_VALUE),
    );
  }

  const Order._({
    required this.total,
    required this.tipPercent,
  });

  final double total;
  final int tipPercent;

  double get tipAmount => total * (tipPercent / 100);
  double get totalWithTipAmount => total + tipAmount;

  Order copyWith({
    double? total,
    int? tipPercent,
  }) {
    if ((total == null || identical(total, this.total)) &&
        (tipPercent == null || identical(tipPercent, this.tipPercent))) {
      return this;
    }

    return Order(
      total: Utils.greater(total ?? this.total, MIN_VALUE),
      tipPercent: Utils.greater(tipPercent ?? this.tipPercent, MIN_VALUE),
    );
  }
}

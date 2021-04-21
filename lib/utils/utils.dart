import 'package:intl/intl.dart';

abstract class Utils {
  static String formatMoney(num money) {
    final formatter = NumberFormat.currency(
      decimalDigits: 2,
      name: r'$',
      symbol: r'$',
    );
    return formatter.format(money);
  }

  static T between<T extends num>(
    T value, {
    required num min,
    required num max,
  }) {
    if (value < min) {
      return min as T;
    } else if (value > max) {
      return max as T;
    }
    return value;
  }

  static T greater<T extends num>(T value, num min) {
    return between(value, min: min, max: double.maxFinite);
  }

  static T less<T extends num>(T value, T max) {
    return between(value, min: -double.maxFinite, max: max);
  }
}

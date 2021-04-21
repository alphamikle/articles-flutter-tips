import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class NumberFormatter implements TextInputFormatter {
  NumberFormatter({
    this.int = false,
  });

  final bool int;

  TextInputFormatter? initialFormatter;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (int) {
      initialFormatter ??= FilteringTextInputFormatter.allow(
        RegExp(r'[0-9]'),
      );
    } else {
      initialFormatter ??= FilteringTextInputFormatter.allow(
        RegExp(r'[0-9\.]'),
      );
    }
    final value = initialFormatter!.formatEditUpdate(oldValue, newValue);
    final text = value.text;
    if (RegExp(r'^0.+').hasMatch(text)) {
      final replacedText = text.replaceFirst(RegExp(r'^0'), '');
      return value.copyWith(
        text: replacedText,
        selection: TextSelection.fromPosition(
          TextPosition(
            offset: replacedText.length,
            affinity: TextAffinity.downstream,
          ),
        ),
      );
    }
    return value;
  }
}

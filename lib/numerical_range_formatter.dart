import 'package:flutter/services.dart';

class NumericalRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final isMinOn = min > 0;
    final isMaxOn = max > 0;
    final String newNumber = newValue.text.replaceAll(",", "");

    if (newNumber == '') {
      return newValue;
    } else if (isMinOn && double.parse(newNumber) < min) {
      return const TextEditingValue().copyWith(text: min.toString());
    } else if (isMaxOn && double.parse(newNumber) > max) {
      // return double.parse(newNumber) > max ? oldValue : newValue;
      return oldValue;
    } else {
      return newValue;
    }
  }
}

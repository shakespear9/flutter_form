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
    final String newNumber = newValue.text.replaceAll(",", "");

    if (newNumber == '') {
      return newValue;
    } else if (double.parse(newNumber) < min) {
      return const TextEditingValue().copyWith(text: min.toString());
    } else {
      return double.parse(newNumber) > max ? oldValue : newValue;
    }
  }
}

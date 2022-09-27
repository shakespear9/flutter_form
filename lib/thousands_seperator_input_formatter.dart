// import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  // static const separator = ',';
  // static const decimalDigits = 4;
  // static const numberMaxLength = 8;

  final int decimalDigits;
  final int precedingDigits;

  final String _separator = ',';

  ThousandsSeparatorInputFormatter(
      {this.precedingDigits = 8, this.decimalDigits = 4});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newString = newValue.text.trim();

    var f = NumberFormat.currency(
        locale: "en_US", symbol: "", decimalDigits: decimalDigits);

    if (newString.replaceAll(_separator, '') == '') {
      return newValue.copyWith(text: '');
    }

    if (newValue.text.trim().length == 1 &&
        RegExp(r'[0-9]').hasMatch(newString)) {
      return newValue;
    }

    if (newValue.text.contains('$_separator.') ||
        newValue.text.contains('.$_separator')) {
      return oldValue;
    }

    var countNewDot = '.'.allMatches(newString).length;
    var countOldDot = '.'.allMatches(oldValue.text).length;
    int selectionIndex = newValue.text.length - newValue.selection.extentOffset;

    if (countNewDot > 1) {
      return oldValue;
    }

    if (countNewDot == 0 && countOldDot == 1) {
      var numberAfterDot = oldValue.text.split(".")[1];
      if (numberAfterDot != '') {
        return oldValue;
      }
    }

    if (countNewDot == 1) {
      var numberAfterDot = newValue.text.split(".")[1];
      if (numberAfterDot.length > decimalDigits) {
        return oldValue;
      }
    }

    String number = newString.replaceAll(_separator, '');
    if (number.contains('.')) {
      number = number.split(".")[0];
    }
    if (number.length > precedingDigits) {
      return oldValue;
    }

    if (oldValue.text.replaceAll(_separator, '') ==
        newValue.text.replaceAll(_separator, '')) {
      if (oldValue.selection.start > newValue.selection.start) {
        var currentIndex = newValue.selection.start;

        newString = newString.substring(0, currentIndex - 1) +
            newString.substring(currentIndex, newString.length);
        newString = newString.replaceAll(_separator, '');

        newString = f.format(double.parse(newString));

        if (countNewDot == 0) {
          newString = newString.split(".")[0];
        } else {
          var numberAfterDot = newValue.text.split(".")[1];

          if (numberAfterDot.length > decimalDigits) {
            numberAfterDot = numberAfterDot.substring(0, decimalDigits);
          }
          newString = '${newString.split(".")[0]}.$numberAfterDot';
        }

        var offset = currentIndex;

        if ((oldValue.text.length - newString.length) > 1) {
          offset = offset - 1;
        }

        return TextEditingValue(
          text: newString,
          selection: TextSelection.collapsed(
            offset: offset,
          ),
        );
      }
    }

    newString = newString.replaceAll(_separator, '');

    if (newString == ".") {
      newString = '0.';
    }

    newString = f.format(double.parse(newString));

    if (countNewDot == 0) {
      newString = newString.split(".")[0];
    } else {
      var decimalNumber = newValue.text.split(".")[1];
      if (decimalNumber.length > decimalDigits) {
        decimalNumber = decimalNumber.substring(0, decimalDigits);
      }
      newString = '${newString.split(".")[0]}.$decimalNumber';
    }

    return TextEditingValue(
      text: newString,
      selection: TextSelection.collapsed(
        offset: newString.length - selectionIndex,
      ),
    );
  }
}

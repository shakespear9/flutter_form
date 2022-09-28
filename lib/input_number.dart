// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form/numerical_range_formatter.dart';
import 'package:intl/intl.dart';

import 'thousands_seperator_input_formatter.dart';

class InputNumber extends StatefulWidget {
  const InputNumber(
      {super.key,
      this.decimalDigits = 0,
      this.precedingDigits = 8,
      this.min = 0,
      this.max = 0});

  final int decimalDigits;
  final int precedingDigits;
  final double min;
  final double max;

  @override
  State<InputNumber> createState() => _InputNumberState();
}

class _InputNumberState extends State<InputNumber> {
  @override
  Widget build(BuildContext context) {
    // final format =
    //     "99,999,999${widget.decimalDigits > 0 ? "." : ""}${"9" * widget.decimalDigits}";

    final numberFormat = NumberFormat("#,##0", "en_US");

    final regex = widget.decimalDigits > 0 ? "[0-9.,]" : "[0-9,]";
    final isLimit = widget.min != 0 || widget.max != 0;

    final decimalFormat =
        "${widget.decimalDigits > 0 ? "." : ""}${"9" * widget.decimalDigits}";
    final precedingFormat = "9" * widget.precedingDigits;

    final String hintText =
        "${numberFormat.format(int.parse(precedingFormat))}$decimalFormat";

    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(regex)),
        if (isLimit) NumericalRangeFormatter(min: widget.min, max: widget.max),
        ThousandsSeparatorInputFormatter(
            decimalDigits: widget.decimalDigits,
            precedingDigits: widget.precedingDigits),
      ],
      keyboardType:
          const TextInputType.numberWithOptions(decimal: false, signed: false),
    );
  }
}

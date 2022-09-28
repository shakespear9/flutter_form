import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form/input_number.dart';
import 'package:flutter_form/thousands_seperator_input_formatter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Item Master',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExamplePage(),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  ExamplePageState createState() => ExamplePageState();
}

class ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: buildTextField(),
    );
  }

  Widget buildTextField() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '99,999,999.9999',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ThousandsSeparatorInputFormatter(decimalDigits: 2),
              ],
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: false, signed: false),
            ),
            const InputNumber(
              decimalDigits: 0,
              // isLimit: true,
              // min: 0,
              // max: 10000,
            ),
            const InputNumber(
              decimalDigits: 2,
              precedingDigits: 5,
              // isLimit: true,
              // min: 0,
              // max: 10000,
            ),
            const InputNumber(
              decimalDigits: 0,
              precedingDigits: 5,
              // isLimit: true,
              // min: 3,
              max: 50000,
            ),
            TextFormField()
          ],
        ));
  }
}

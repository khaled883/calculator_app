import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = "";
  double? firstNumber;
  String? operation;

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        displayText = "";
        firstNumber = null;
        operation = null;
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        firstNumber = double.tryParse(displayText);
        operation = value;
        displayText = "";
      } else if (value == '=') {
        double? secondNumber = double.tryParse(displayText);
        if (firstNumber != null && secondNumber != null && operation != null) {
          double result;
          switch (operation) {
            case '+':
              result = firstNumber! + secondNumber;
              break;
            case '-':
              result = firstNumber! - secondNumber;
              break;
            case '*':
              result = firstNumber! * secondNumber;
              break;
            case '/':
              result = secondNumber != 0
                  ? firstNumber! / secondNumber
                  : 0;
              break;
            default:
              result = 0;
          }
          displayText = result.toString();
          firstNumber = null;
          operation = null;
        }
      } else {
        displayText += value;
      }
    });
  }

  Widget buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromHeight(100),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
          ),

          onPressed: () => onButtonPressed(text),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Basic Calculator"),
      centerTitle: true,),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
            color: Colors.grey[300],
            ),
            height: MediaQuery.of(context).size.height*0.3,
            
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(16),
            child: Text(
              displayText,
              style: const TextStyle(fontSize: 60),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(children: [buildButton('7'), buildButton('8'), buildButton('9'), buildButton('/')]),
                Row(children: [buildButton('4'), buildButton('5'), buildButton('6'), buildButton('*')]),
                Row(children: [buildButton('1'), buildButton('2'), buildButton('3'), buildButton('-')]),
                Row(children: [buildButton('0'), buildButton('C'), buildButton('='), buildButton('+')]),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

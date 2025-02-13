import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double firstNumber = 0.0;
  double secondNumber = 0.0;
  var input = '';
  var output = '';
  var operator = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value) {


    if (value == 'AC') {
      input = '';
      output = '';
    }
    else if(value == '<') {
      input = input.substring(0, input.length - 1);
    } else if(value == '='){
      if (input.isNotEmpty) {
        var userInput = input;
      }
      var userInput = input;
      userInput = input.replaceAll("x", "*");
      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm  = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
      if (output.endsWith(".0")){
        output = output.substring(0, output.length - 2);
      }
      input = output;
      hideInput = true;
      outputSize = 52;
    }
    else {
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
              child: Container(
                width: double.infinity,
            padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     Text(
                       hideInput ? '' : input, style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      output, style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    ),
                    SizedBox(height: 30),
                  ],
                )
          )
          ),
          Row(
            children: [
              button(text: "AC", buttonBgColor: operateColors,
                  tColor: orangeColors),
              button(text: "<", buttonBgColor: operateColors, tColor: orangeColors),
              button(text: "", buttonBgColor: Colors.transparent, tColor: orangeColors),
              button(text: "/", buttonBgColor: operateColors, tColor: orangeColors),
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9", buttonBgColor: Colors.transparent),
              button(text: "x", tColor: orangeColors),
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6", buttonBgColor: Colors.transparent),
              button(text: "-", tColor: orangeColors),
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3", buttonBgColor: Colors.transparent),
              button(text: "+", tColor: orangeColors),
            ],
          ),
          Row(
            children: [
              button(text: "%",tColor: orangeColors),
              button(text: "0"),
              button(text: ".", buttonBgColor: Colors.transparent),
              button(text: "=", tColor: orangeColors),
            ],
          ),
        ],
      ),
    );
  }
  Widget button({
    text, tColor = Colors.white,
    buttonBgColor = buttonColors
}) {
    return  Expanded(child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(22),
              backgroundColor: buttonColors
          ),
          onPressed: () => onButtonClick(text),
          child: Text(text, style: TextStyle(
              fontSize: 18,
              color: tColor,
              fontWeight: FontWeight.bold
          ),),
        )
    )
    );

  }
}

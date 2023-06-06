import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '';

  void _updateExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  void _evaluateExpression() {
    Parser parser = Parser();
    Expression expression = parser.parse(_expression);
    ContextModel contextModel = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, contextModel);

    setState(() {
      _result = eval.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            '계산기',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _expression,
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _result,
                style: const TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  CalculatorButton('7', _updateExpression),
                  CalculatorButton('8', _updateExpression),
                  CalculatorButton('9', _updateExpression),
                  CalculatorButton('/', _updateExpression),
                  CalculatorButton('4', _updateExpression),
                  CalculatorButton('5', _updateExpression),
                  CalculatorButton('6', _updateExpression),
                  CalculatorButton('*', _updateExpression),
                  CalculatorButton('1', _updateExpression),
                  CalculatorButton('2', _updateExpression),
                  CalculatorButton('3', _updateExpression),
                  CalculatorButton('-', _updateExpression),
                  CalculatorButton('0', _updateExpression),
                  CalculatorButton('.', _updateExpression),
                  CalculatorButton('=', (String text) {
                    _evaluateExpression();
                  }),
                  CalculatorButton('+', _updateExpression),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              // height: 45,
              child: Center(
                child: TextButton(
                  onPressed: _clearExpression,
                  child: const Text(
                    'Clear',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function(String) onPressed;

  const CalculatorButton(this.text, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => onPressed(text),
        child: Text(
          text,
          style: const TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}

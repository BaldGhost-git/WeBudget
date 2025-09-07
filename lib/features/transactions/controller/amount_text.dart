import 'package:flutter/material.dart';

const mathOps = ['+', '-', 'x', '/'];

class AmountText with ChangeNotifier {
  String _amount = "0";
  String get amount => _amount;

  void calculate() {
    // Parse and evaluate the expression in `_amount`
    // Supported ops: +, -, x, /
    // Precedence: x and / before + and - (left-associative)
    if (_amount.isEmpty) {
      _amount = "0";
      notifyListeners();
      return;
    }

    // Trim trailing operator if present
    String expression = _amount;
    while (expression.isNotEmpty && mathOps.contains(expression[expression.length - 1])) {
      expression = expression.substring(0, expression.length - 1);
    }
    if (expression.isEmpty) {
      _amount = "0";
      notifyListeners();
      return;
    }

    // Tokenize numbers and operators (assumes at most one '.' per number
    // due to validation in add())
    final operands = <double>[];
    final operators = <String>[];
    final currentToken = StringBuffer();
    for (int i = 0; i < expression.length; i++) {
      final ch = expression[i];
      final codeUnit = ch.codeUnitAt(0);
      if (codeUnit >= 0x30 && codeUnit <= 0x39) {
        // Digit '0'(0x30)..'9'(0x39)
        currentToken.write(ch);
      } else if (ch == '.') {
        // prefix leading dot with 0 (e.g., .5 -> 0.5)
        if (currentToken.isEmpty) currentToken.write('0');
        currentToken.write('.');
      } else if (mathOps.contains(ch)) {
        // flush current number
        String numberString = currentToken.toString();
        if (numberString.isEmpty) {
          // Implicit 0 before a leading operator (e.g., 0-5)
          operands.add(0.0);
        } else {
          if (numberString.endsWith('.')) {
            numberString = numberString.substring(0, numberString.length - 1);
          }
          operands.add(double.tryParse(numberString) ?? 0.0);
        }
        currentToken.clear();
        operators.add(ch);
      }
    }
    // flush last number
    String lastNumberString = currentToken.toString();
    if (lastNumberString.isNotEmpty) {
      if (lastNumberString.endsWith('.')) {
        lastNumberString = lastNumberString.substring(0, lastNumberString.length - 1);
      }
      operands.add(double.tryParse(lastNumberString) ?? 0.0);
    }

    // Guard: need at least one number
    if (operands.isEmpty) {
      _amount = "0";
      notifyListeners();
      return;
    }

    // First pass: handle multiplication and division
    final collapsedOperands = <double>[];
    final collapsedOperators = <String>[];
    // Invariant: number of operands is exactly operators + 1
    assert(operators.length + 1 == operands.length,
        'Mismatched operands/operators');
    if (operators.length + 1 != operands.length) {
      _amount = "0";
      notifyListeners();
      return;
    }
    double runningProductQuotient = operands[0];
    for (int i = 0; i < operators.length; i++) {
      final operator = operators[i];
      final nextOperand = operands[i + 1];
      if (operator == 'x') {
        runningProductQuotient = runningProductQuotient * nextOperand;
      } else if (operator == '/') {
        runningProductQuotient = runningProductQuotient / nextOperand;
      } else {
        collapsedOperands.add(runningProductQuotient);
        collapsedOperators.add(operator);
        runningProductQuotient = nextOperand;
      }
    }
    collapsedOperands.add(runningProductQuotient);

    // Second pass: handle addition and subtraction
    double finalResult = collapsedOperands[0];
    for (int i = 0; i < collapsedOperators.length; i++) {
      final operator = collapsedOperators[i];
      final nextOperand = collapsedOperands[i + 1];
      if (operator == '+') {
        finalResult += nextOperand;
      } else {
        finalResult -= nextOperand;
      }
    }

    // Format result: trim trailing .0
    String out;
    if (finalResult.isNaN || finalResult.isInfinite) {
      out = "0";
    } else {
      final intPart = finalResult.truncate();
      if (finalResult == intPart) {
        out = intPart.toString();
      } else {
        out = finalResult.toString();
      }
    }
    _amount = out;
    notifyListeners();
  }

  void add(String text) {
    int lastIndex = _amount.length - 1;
    if (text == '.' && _amount.contains(text)) return;
    if (mathOps.contains(text)) {
      if (_amount.endsWith(text)) return;
      if (mathOps.contains(_amount[lastIndex])) {
        _amount = _amount.substring(0, lastIndex) + text;
      } else {
        _amount = _amount + text;
      }
    } else if (_amount == '0' && text != '.') {
      _amount = text;
    } else {
      _amount = _amount + text;
    }
    notifyListeners();
  }

  void delete() {
    String temp = _amount.substring(0, _amount.length - 1);
    if (_amount.isEmpty || temp.isEmpty) {
      _amount = "0";
    } else {
      _amount = temp;
    }
    notifyListeners();
  }

  void zero() {
    _amount = "0";
    notifyListeners();
  }
}

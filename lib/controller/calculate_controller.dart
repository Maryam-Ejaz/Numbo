import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_calculator/history_item.dart';
import 'historyController.dart';


class CalculateController extends GetxController {
  var controller = Get.find<HistoryController>();

  var userInput = "";
  var userOutput = "";
  static const int maxDigits = 15;

  get context => null; // maximum number of digits

  /// Clear Button Pressed
  clearInputAndOutput() {
    userInput = "";
    userOutput = "";
    update();
  }

  /// Delete Button Pressed
  deleteBtnAction() {
    userInput = userInput.substring(0, userInput.length - 1);
    update();
  }

  /// Number Button Tapped
  onBtnTapped(List<String> buttons, int index) {
    if (userInput.isEmpty && isOperator(buttons[index])) {
      // Prevent adding an operator as the first input
      return;
    }

    if (isOperator(buttons[index]) || buttons[index] == ".") {
      userInput += buttons[index];
    } else {
      // Count digits in the current input segment (after the last operator)
      int digitCount = 0;
      for (int i = userInput.length - 1; i >= 0; i--) {
        if (isOperator(userInput[i])) break;
        if (RegExp(r'\d').hasMatch(userInput[i])) digitCount++;
      }

      if (digitCount < maxDigits) {
        userInput += buttons[index];
      } else {
        // Show a snack bar
        Get.snackbar(
          "Input Limit Reached",
          "You cannot enter more than $maxDigits digits before an operator",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
    update();
  }

  /// Ans Button Pressed
  onAnsTapped() {
    var historyBox = Hive.box<HistoryItem>('history');
    if (historyBox.isNotEmpty) {
      HistoryItem lastItem = historyBox.values.last;
      userInput += lastItem.title;
    }
    update();
  }

  /// Equal Button Pressed
  equalPressed() {
    String userInput_ = userInput;

    userInput_ = userInput_.replaceAll("x", "*");
    Parser p = Parser();
    Expression exp = p.parse(userInput_);
    ContextModel ctx = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, ctx);

// Check if eval needs to be in exponential form
    if (eval.abs() >= 1e5 || eval.abs() <= 1e-5) {
      userOutput = eval.toStringAsExponential(5); // Limit to 5 decimal places in exponential form
    } else {
      userOutput = eval.toStringAsFixed(5); // Limit to 5 decimal places normally
    }

    // Convert to integer if all decimal places are zero
    if (double.parse(userOutput) == double.parse(userOutput).roundToDouble()) {
      userOutput = double.parse(userOutput).round().toString();
    }

    /// Save the result to history
    var historyItem = HistoryItem(userOutput, userInput);
    var historyBox = Hive.box<HistoryItem>('history');
    historyBox.add(historyItem);
    controller.loadHistory();

    update();
  }

  /// Operator Check
  bool isOperator(String y) {
    if (y == "%" || y == "/" || y == "x" || y == "-" || y == "+" || y == "=") {
      return true;
    }
    return false;
  }


}

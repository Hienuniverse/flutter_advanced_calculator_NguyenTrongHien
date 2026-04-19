import 'package:math_expressions/math_expressions.dart';

class ExpressionParser {
  static String evaluate(String expression) {
    if (expression.isEmpty) return '0';

    try {
      // Chuẩn hóa chuỗi [cite: 113, 119]
      String finalExpression = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', '3.14159265359')
          .replaceAll('e', '2.71828182846')
          .replaceAll('%', '/100');

      Parser p = Parser();
      Expression exp = p.parse(finalExpression);
      ContextModel cm = ContextModel();
      
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval.isInfinite || eval.isNaN) {
        return 'Error: Division by zero'; // Bắt lỗi chia cho 0 [cite: 114, 185]
      }

      String result = eval.toString();
      if (result.endsWith('.0')) {
        result = result.substring(0, result.length - 2);
      }
      return result;
    } catch (e) {
      return 'Error: Invalid input'; // Bắt lỗi cú pháp [cite: 114, 185]
    }
  }
}
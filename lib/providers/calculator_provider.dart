import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../models/calculator_mode.dart';

class CalculatorProvider extends ChangeNotifier {
  String _expression = '';
  String _result = '0';
  CalculatorMode _mode = CalculatorMode.basic;
  AngleMode _angleMode = AngleMode.degrees;
  double _memory = 0;
  bool _hasMemory = false;

  // Getters để UI có thể đọc dữ liệu
  String get expression => _expression;
  String get result => _result;
  CalculatorMode get mode => _mode;
  AngleMode get angleMode => _angleMode;
  double get memory => _memory;
  bool get hasMemory => _hasMemory;

  // --- Các phương thức xử lý (Methods) ---

  void addToExpression(String value) {
    _expression += value;
    notifyListeners();
  }

  void calculate() {
    if (_expression.isEmpty) return;

    try {
      // 1. Chuẩn hóa chuỗi (Sanitize Expression)
      String finalExpression = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', '3.14159265359')
          .replaceAll('e', '2.71828182846')
          .replaceAll('%', '/100'); // Xử lý phần trăm [cite: 100, 102]

      // 2. Phân tích và tính toán [cite: 16, 110]
      Parser p = Parser();
      Expression exp = p.parse(finalExpression);
      
      ContextModel cm = ContextModel();
      
      // Tính toán kết quả thực tế
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // 3. Xử lý các trường hợp lỗi như chia cho 0 [cite: 114, 185]
      if (eval.isInfinite || eval.isNaN) {
        _result = 'Error: Division by zero';
      } else {
        // Làm đẹp kết quả: Xóa đuôi ".0" nếu là số nguyên
        _result = eval.toString();
        if (_result.endsWith('.0')) {
          _result = _result.substring(0, _result.length - 2);
        }
      }

      // TODO: Gọi hàm từ HistoryProvider để lưu vào lịch sử tại đây [cite: 17, 122]

    } catch (e) {
      // Bắt lỗi khi người dùng nhập sai cú pháp [cite: 114]
      _result = 'Error: Invalid input';
    }
    
    notifyListeners(); // Báo cho UI cập nhật
  }

  void clear() {
    _expression = '';
    _result = '0';
    notifyListeners();
  }

  void clearEntry() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  void toggleMode(CalculatorMode newMode) {
    _mode = newMode;
    notifyListeners();
  }

  void toggleAngleMode() {
    _angleMode = _angleMode == AngleMode.degrees ? AngleMode.radians : AngleMode.degrees;
    notifyListeners();
  }

  void toggleSign() {
    if (_result != '0' && !_result.startsWith('Error')) {
      if (_result.startsWith('-')) {
        _result = _result.substring(1); // Bỏ dấu trừ
      } else {
        _result = '-$_result'; // Thêm dấu trừ
      }
      notifyListeners();
    }
  }

  void addPercentage() {
    addToExpression('%');
  }

  void addScientificFunction(String func) {
    addToExpression('$func('); // Thêm hàm khoa học kèm dấu ngoặc mở, VD: sin( [cite: 115, 116]
  }

  // --- Các hàm bộ nhớ (Memory Functions) --- [cite: 19, 121, 180]

  void memoryAdd() {
    _memory += double.tryParse(_result) ?? 0;
    _hasMemory = true;
    notifyListeners();
  }

  void memorySubtract() {
    _memory -= double.tryParse(_result) ?? 0;
    _hasMemory = true;
    notifyListeners();
  }

  void memoryRecall() {
    // Đưa giá trị từ bộ nhớ vào chuỗi tính toán
    addToExpression(_memory.toString());
  }

  void memoryClear() {
    _memory = 0;
    _hasMemory = false;
    notifyListeners();
  }
}
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

  // Getters để UI truy xuất dữ liệu
  String get expression => _expression;
  String get result => _result;
  CalculatorMode get mode => _mode;
  AngleMode get angleMode => _angleMode;
  double get memory => _memory;
  bool get hasMemory => _hasMemory;

  // Thêm giá trị vào biểu thức (số, toán tử)
  void addToExpression(String value) {
    _expression += value;
    notifyListeners();
  }

  // Hàm tính toán chính
  void calculate() {
    if (_expression.isEmpty) return;

    try {
      // 1. Chuẩn hóa biểu thức sang định dạng máy tính hiểu được
      String finalExpression = _expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('π', '3.14159265359')
          .replaceAll('e', '2.71828182846')
          .replaceAll('%', '/100');

      // 2. Sử dụng thư viện math_expressions để phân tích chuỗi
      Parser p = Parser();
      Expression exp = p.parse(finalExpression);
      ContextModel cm = ContextModel();
      
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // 3. Xử lý kết quả và các trường hợp lỗi
      if (eval.isInfinite || eval.isNaN) {
        _result = 'Error: Division by zero';
      } else {
        // Định dạng lại kết quả: bỏ đuôi .0 nếu là số nguyên
        _result = eval.toString();
        if (_result.endsWith('.0')) {
          _result = _result.substring(0, _result.length - 2);
        }
      }
    } catch (e) {
      _result = 'Error: Invalid input';
    }
    
    notifyListeners();
  }

  // Xóa toàn bộ
  void clear() {
    _expression = '';
    _result = '0';
    notifyListeners();
  }

  // Xóa ký tự cuối cùng (Backspread)
  void clearEntry() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      notifyListeners();
    }
  }

  // Đổi chế độ máy tính (Basic/Scientific/Programmer)
  void toggleMode(CalculatorMode newMode) {
    _mode = newMode;
    notifyListeners();
  }

  // Đổi đơn vị góc (DEG/RAD)
  void toggleAngleMode() {
    _angleMode = _angleMode == AngleMode.degrees ? AngleMode.radians : AngleMode.degrees;
    notifyListeners();
  }

  // SỬA LỖI: Hàm đổi dấu âm/dương (toggleSign)
  void toggleSign() {
    if (_expression.isEmpty && _result != '0' && !_result.startsWith('Error')) {
      // Đổi dấu dựa trên kết quả trước đó
      if (_result.startsWith('-')) {
        _expression = _result.substring(1);
      } else {
        _expression = '-$_result';
      }
    } else if (_expression.isNotEmpty) {
      // Đổi dấu biểu thức đang nhập bằng cách bọc ngoặc
      if (_expression.startsWith('-(') && _expression.endsWith(')')) {
        _expression = _expression.substring(2, _expression.length - 1);
      } else if (_expression.startsWith('-')) {
        _expression = _expression.substring(1);
      } else {
        _expression = '-($_expression)';
      }
    } else {
      _expression = '-';
    }
    notifyListeners();
  }

  // Thêm ký hiệu %
  void addPercentage() {
    addToExpression('%');
  }

  // Thêm các hàm khoa học (sin, cos, log...)
  void addScientificFunction(String func) {
    addToExpression('$func(');
  }

  // --- CÁC HÀM BỘ NHỚ (MEMORY) ---

  void memoryAdd() {
    double currentVal = double.tryParse(_result) ?? 0;
    _memory += currentVal;
    _hasMemory = true;
    notifyListeners();
  }

  void memorySubtract() {
    double currentVal = double.tryParse(_result) ?? 0;
    _memory -= currentVal;
    _hasMemory = true;
    notifyListeners();
  }

  void memoryRecall() {
    // Gọi giá trị từ bộ nhớ và đưa vào biểu thức
    String memStr = _memory.toString();
    if (memStr.endsWith('.0')) memStr = memStr.substring(0, memStr.length - 2);
    addToExpression(memStr);
  }

  void memoryClear() {
    _memory = 0;
    _hasMemory = false;
    notifyListeners();
  }
}
import 'package:flutter_test/flutter_test.dart';
import '../lib/providers/calculator_provider.dart';

void main() {
  late CalculatorProvider calculator;

  //Hàm này chạy trước mỗi test case để reset lại máy tính
  setUp(() {
    calculator = CalculatorProvider();
  });

  group('1. Basic Arithmetic Operations', () {
    test('Phép cộng', () {
      calculator.addToExpression('5+3');
      calculator.calculate();
      expect(calculator.result, '8');
    });

    test('Phép trừ', () {
      calculator.addToExpression('10-4');
      calculator.calculate();
      expect(calculator.result, '6');
    });

    test('Phép nhân', () {
      calculator.addToExpression('6×7'); //Dùng dấu × giống UI
      calculator.calculate();
      expect(calculator.result, '42');
    });

    test('Phép chia', () {
      calculator.addToExpression('15÷3'); //Dùng dấu ÷ giống UI
      calculator.calculate();
      expect(calculator.result, '5');
    });
  });

  group('2. Order of Operations & Parentheses', () {
    test('Nhân chia trước, cộng trừ sau', () {
      calculator.addToExpression('2+3×4');
      calculator.calculate();
      expect(calculator.result, '14');
    });

    test('Dấu ngoặc đơn', () {
      calculator.addToExpression('(2+3)×4');
      calculator.calculate();
      expect(calculator.result, '20');
    });
  });

  group('3. Scientific Functions', () {
    test('Căn bậc 2', () {
      calculator.addToExpression('sqrt(16)');
      calculator.calculate();
      expect(calculator.result, '4');
    });

    test('Hàm lượng giác cơ bản (sin 0)', () {
      calculator.addToExpression('sin(0)');
      calculator.calculate();
      expect(calculator.result, '0');
    });
  });

  group('4. Edge Cases & Error Handling', () {
    test('Lỗi chia cho 0', () {
      calculator.addToExpression('5÷0');
      calculator.calculate();
      expect(calculator.result, 'Error: Division by zero');
    });

    test('Lỗi cú pháp (Invalid Input)', () {
      calculator.addToExpression('5+×3');
      calculator.calculate();
      expect(calculator.result, 'Error: Invalid input');
    });
  });

  group('5. Memory Functions', () {
    test('Lưu và gọi bộ nhớ (M+, MR)', () {
      //Tính 5 + 3 = 8
      calculator.addToExpression('5+3');
      calculator.calculate();
      
      //Lưu 8 vào bộ nhớ
      calculator.memoryAdd();
      expect(calculator.hasMemory, true);
      expect(calculator.memory, 8.0);

      //Xóa màn hình, gọi bộ nhớ
      calculator.clear();
      calculator.memoryRecall();
      expect(calculator.expression, '8');
    });
  });
}
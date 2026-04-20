import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart';
import 'calculator_button.dart';

class ScientificButtonGrid extends StatelessWidget {
  const ScientificButtonGrid({Key? key}) : super(key: key);

  // Mảng 36 phím theo đúng cấu trúc của Lab (6 cột x 6 hàng) 
  final List<String> buttons = const [
    '2nd', 'sin', 'cos', 'tan', 'ln', 'log',
    'x²', '√', 'x^y', '(', ')', '÷',
    'MC', '7', '8', '9', 'C', '×',
    'MR', '4', '5', '6', 'CE', '-',
    'M+', '1', '2', '3', '%', '+',
    'M-', '±', '0', '.', 'π', '='
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: buttons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6, // 6 cột cho Scientific Mode
        crossAxisSpacing: 8, // Thu nhỏ spacing lại một chút vì nhiều cột
        mainAxisSpacing: 8,
        childAspectRatio: 1.0, 
      ),
      itemBuilder: (context, index) {
        final btnText = buttons[index];
        
        Color? bgColor;
        Color? textColor;
        
        // Cấu hình màu sắc
        if (['÷', '×', '-', '+', '='].contains(btnText)) {
          bgColor = Theme.of(context).colorScheme.secondary;
          textColor = Colors.white;
        } else if (['C', 'CE', 'MC', 'MR', 'M+', 'M-'].contains(btnText)) {
          bgColor = Colors.grey[700];
          textColor = Colors.white;
        } else if (['sin', 'cos', 'tan', 'ln', 'log', 'x²', '√', 'x^y', '(', ')', '2nd', 'π'].contains(btnText)) {
          bgColor = Theme.of(context).cardColor.withOpacity(0.7); // Màu nhạt hơn cho phím chức năng
        }

        return CalculatorButton(
          text: btnText,
          backgroundColor: bgColor,
          textColor: textColor,
          onTap: () {
            // --- XỬ LÝ LOGIC BẤM NÚT SCIENTIFIC ---
            if (btnText == 'C') provider.clear();
            else if (btnText == 'CE') provider.clearEntry();
            else if (btnText == '=') {
              provider.calculate();
              if (!provider.result.startsWith('Error')) {
                context.read<HistoryProvider>().addHistory(provider.expression, provider.result);
              }
            }
            // Memory [cite: 102]
            else if (btnText == 'MC') provider.memoryClear();
            else if (btnText == 'MR') provider.memoryRecall();
            else if (btnText == 'M+') provider.memoryAdd();
            else if (btnText == 'M-') provider.memorySubtract();
            // Math Functions [cite: 102]
            else if (['sin', 'cos', 'tan', 'ln', 'log'].contains(btnText)) {
              provider.addScientificFunction(btnText);
            } 
            else if (btnText == '√') provider.addScientificFunction('sqrt');
            else if (btnText == 'x²') provider.addToExpression('^2');
            else if (btnText == 'x^y') provider.addToExpression('^');
            else if (btnText == '±') provider.toggleSign();
            else if (btnText == '%') provider.addPercentage();
            else if (btnText == '2nd') { /* TODO: Đảo ngược hàm (asin, acos) */ }
            else {
              provider.addToExpression(btnText);
            }
          },
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../providers/history_provider.dart'; //THÊM DÒNG NÀY ĐỂ GỌI HISTORY
import 'calculator_button.dart';

class BasicButtonGrid extends StatelessWidget {
  const BasicButtonGrid({Key? key}) : super(key: key);

  final List<String> buttons = const [
    'C', 'CE', '%', '÷',
    '7', '8', '9', '×',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '±', '0', '.', '='
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: buttons.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12, 
        mainAxisSpacing: 12,
        childAspectRatio: 1.0, 
      ),
      itemBuilder: (context, index) {
        final btnText = buttons[index];
        
        Color? bgColor;
        Color? textColor;
        
        if (['÷', '×', '-', '+', '='].contains(btnText)) {
          bgColor = Theme.of(context).colorScheme.secondary; 
          textColor = Colors.white;
        } else if (['C', 'CE', '%'].contains(btnText)) {
          bgColor = Colors.grey[700];
          textColor = Colors.white;
        }

        return CalculatorButton(
          text: btnText,
          backgroundColor: bgColor,
          textColor: textColor,
          onTap: () {
            //Mapping hành động tương ứng với nút bấm
            if (btnText == 'C') {
              provider.clear();
            } else if (btnText == 'CE') {
              provider.clearEntry();
            } else if (btnText == '=') {
              
              provider.calculate();
              if (!provider.result.startsWith('Error')) {
                //Đọc HistoryProvider thông qua context để lưu kết quả
                context.read<HistoryProvider>().addHistory(provider.expression, provider.result);
              }
              // ---------------------------------------------
              
            } else if (btnText == '±') {
              provider.toggleSign();
            } else if (btnText == '%') {
              provider.addPercentage();
            } else {
              provider.addToExpression(btnText);
            }
          },
        );
      },
    );
  }
}
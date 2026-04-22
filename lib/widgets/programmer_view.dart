import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import 'calculator_button.dart';

class ProgrammerView extends StatelessWidget {
  const ProgrammerView({Key? key}) : super(key: key);

  final List<String> progButtons = const [
    'AND', 'OR', 'XOR', 'NOT',
    '<<', '>>', 'C', 'CE',
    'A', 'B', '7', '8', '9',
    'C', 'D', '4', '5', '6',
    'E', 'F', '1', '2', '3',
    '(', ')', '±', '0', '='
  ];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);

    //Lấy kết quả hiện tại ép kiểu sang số nguyên để chuyển hệ cơ số
    int currentValue = int.tryParse(provider.result.split('.')[0]) ?? 0;

    return Column(
      children: [
        // --- BẢNG HIỂN THỊ CÁC HỆ CƠ SỐ ---
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            children: [
              _buildBaseRow('HEX', currentValue.toRadixString(16).toUpperCase()),
              _buildBaseRow('DEC', currentValue.toString()),
              _buildBaseRow('OCT', currentValue.toRadixString(8)),
              _buildBaseRow('BIN', currentValue.toRadixString(2)),
            ],
          ),
        ),
        const Divider(),
        
        // --- LƯỚI BÀN PHÍM PROGRAMMER ---
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: progButtons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5, //5 cột cho dễ xếp phím A-F
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final btnText = progButtons[index];
              return CalculatorButton(
                text: btnText,
                //Các phím chữ (A-F) và phép toán Bitwise [cite: 105, 106] đổi màu cho khác biệt
                backgroundColor: ['A','B','C','D','E','F', 'AND', 'OR', 'XOR', 'NOT', '<<', '>>'].contains(btnText) 
                  ? Theme.of(context).cardColor.withOpacity(0.6) 
                  : null,
                onTap: () {
                  // TODO: Bổ sung logic Bitwise vào CalculatorProvider sau
                  if (btnText == 'C') provider.clear();
                  else if (btnText == 'CE') provider.clearEntry();
                  else provider.addToExpression(btnText);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBaseRow(String baseName, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 40, 
            child: Text(baseName, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent))
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value.isEmpty ? '0' : value, 
              style: const TextStyle(fontSize: 18, fontFamily: 'monospace') 
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';

class DisplayArea extends StatelessWidget {
  const DisplayArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return Container(
          //Padding theo Specs của Figma
          padding: const EdgeInsets.all(24.0),
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //1. Dòng phép tính hiện tại (cho phép cuộn ngang nếu dài)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true, //Cuộn từ phải sang trái
                child: Text(
                  provider.expression,
                  style: const TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 8),
              
              //2. Kết quả (Tự động thu nhỏ cỡ chữ nếu số quá dài)
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  provider.result,
                  style: TextStyle(
                    fontSize: 48, 
                    fontWeight: FontWeight.bold,
                    //Đổi màu đỏ nếu có lỗi
                    color: provider.result.startsWith('Error') ? Colors.redAccent : null,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
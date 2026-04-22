import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';

class ModeSelector extends StatelessWidget {
  const ModeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Nút Dropdown để chọn chế độ
          DropdownButtonHideUnderline(
            child: DropdownButton<CalculatorMode>(
              value: provider.mode,
              icon: const Icon(Icons.keyboard_arrow_down),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              onChanged: (CalculatorMode? newValue) {
                if (newValue != null) {
                  provider.toggleMode(newValue);
                }
              },
              items: CalculatorMode.values.map((CalculatorMode mode) {
                //Viết hoa chữ cái đầu (VD: basic -> Basic)
                String modeName = mode.toString().split('.').last;
                modeName = modeName[0].toUpperCase() + modeName.substring(1);
                
                return DropdownMenuItem<CalculatorMode>(
                  value: mode,
                  child: Text('$modeName Mode'),
                );
              }).toList(),
            ),
          ),

          //Nút xem lịch sử
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              //TODO: Điều hướng sang History Screen hoặc mở BottomSheet
            },
          ),
        ],
      ),
    );
  }
}
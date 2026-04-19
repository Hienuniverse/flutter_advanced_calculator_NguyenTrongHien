import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';
import '../widgets/display_area.dart';
import '../widgets/mode_selector.dart';
import '../widgets/button_grid.dart'; // Đảm bảo import BasicButtonGrid

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Khu vực hiển thị (Màn hình máy tính) [cite: 87, 88]
            const Expanded(
              flex: 3,
              child: DisplayArea(),
            ),

            // Thanh điều hướng chế độ và cài đặt [cite: 95]
            const ModeSelector(),

            // Khu vực phím bấm [cite: 98]
            Expanded(
              flex: 6,
              child: Consumer<CalculatorProvider>(
                builder: (context, provider, child) {
                  // Hiển thị lưới tương ứng với Mode [cite: 176]
                  if (provider.mode == CalculatorMode.scientific) {
                    return const Center(child: Text('Scientific Grid 6x6')); 
                  } else if (provider.mode == CalculatorMode.programmer) {
                    return const Center(child: Text('Programmer View'));
                  }
                  return const BasicButtonGrid();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
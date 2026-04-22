import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../models/calculator_mode.dart';
import '../widgets/display_area.dart';
import '../widgets/mode_selector.dart';
import '../widgets/button_grid.dart';
import '../widgets/scientific_button_grid.dart';
import '../widgets/programmer_view.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            //Khu vực hiển thị (Màn hình máy tính)
            const Expanded(
              flex: 3,
              child: DisplayArea(),
            ),

            //Thanh điều hướng chế độ và cài đặt
            const ModeSelector(),

            //Khu vực phím bấm
            Expanded(
              flex: 6,
              child: Consumer<CalculatorProvider>(
                builder: (context, provider, child) {
                  //Hiển thị lưới tương ứng với Mode
                  if (provider.mode == CalculatorMode.scientific) {
                    return const ScientificButtonGrid(); 
                  } else if (provider.mode == CalculatorMode.programmer) {
                    return const ProgrammerView();
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
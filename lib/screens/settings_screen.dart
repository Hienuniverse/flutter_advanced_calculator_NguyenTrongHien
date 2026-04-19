import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/calculator_mode.dart';
import '../providers/theme_provider.dart';
import '../providers/calculator_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final calcProvider = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // Cài đặt Theme [cite: 143]
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
          const Divider(),
          // Cài đặt đơn vị đo góc (Chỉ hữu ích cho Scientific Mode) [cite: 145]
          ListTile(
            title: const Text('Angle Mode'),
            trailing: ToggleButtons(
              isSelected: [
                calcProvider.angleMode == AngleMode.degrees,
                calcProvider.angleMode == AngleMode.radians,
              ],
              onPressed: (index) {
                calcProvider.toggleAngleMode();
              },
              children: const [
                Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('DEG')),
                Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('RAD')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
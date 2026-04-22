import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class ThemeProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final isDark = await _storageService.loadTheme();
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _storageService.saveTheme(_themeMode == ThemeMode.dark);
    notifyListeners();
  }

  void setTheme(ThemeMode mode) async {
    _themeMode = mode;
    await _storageService.saveTheme(mode == ThemeMode.dark);
    notifyListeners();
  }

  // --- MÃ MÀU THEO SPEC CỦA BÀI LAB ---

  ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Roboto', // Font chữ bắt buộc
    scaffoldBackgroundColor: const Color(0xFFF5F5F5), //Nền sáng
    primaryColor: const Color(0xFF1E1E1E), 
    cardColor: const Color(0xFF424242), //Màu Secondary dùng cho phím bấm
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1E1E1E),
      secondary: Color(0xFFFF6B6B), //Accent (Màu đỏ/cam cho phím =, toán tử)
    ),
  );

  ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: const Color(0xFF000000), //Nền tối
    primaryColor: const Color(0xFF121212),
    cardColor: const Color(0xFF2C2C2C), //Secondary (phím bấm tối)
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF121212),
      secondary: Color(0xFF4ECDC4), //Accent (Màu xanh ngọc)
    ),
  );
}
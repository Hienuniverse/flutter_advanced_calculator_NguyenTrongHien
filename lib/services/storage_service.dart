import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/calculation_history.dart';

class StorageService {
  static const String _historyKey = 'calculator_history';
  static const String _themeKey = 'app_theme';

  // --- LƯU & LẤY LỊCH SỬ ---
  
  Future<void> saveHistory(List<CalculationHistory> historyList) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Chuyển List Object thành List JSON String
    List<String> jsonList = historyList.map((item) => jsonEncode(item.toJson())).toList();
    
    // Giới hạn lưu 50 phép tính gần nhất (như yêu cầu lab)
    if (jsonList.length > 50) {
      jsonList = jsonList.sublist(jsonList.length - 50);
    }
    
    await prefs.setStringList(_historyKey, jsonList);
  }

  Future<List<CalculationHistory>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_historyKey);
    
    if (jsonList == null) return [];

    return jsonList.map((item) => CalculationHistory.fromJson(jsonDecode(item))).toList();
  }

  // --- LƯU & LẤY THEME (Dark/Light Mode) ---

  Future<void> saveTheme(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode);
  }

  Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false; // Mặc định là false (Light Mode)
  }
}
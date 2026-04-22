import 'package:flutter/material.dart';
import '../models/calculation_history.dart';
import '../services/storage_service.dart';

class HistoryProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  List<CalculationHistory> _history = [];

  List<CalculationHistory> get history => _history;

  //Gọi hàm này khi khởi động app
  Future<void> loadHistory() async {
    _history = await _storageService.loadHistory();
    notifyListeners();
  }

  //Gọi hàm này sau mỗi lần bấm dấu "="
  Future<void> addHistory(String expression, String result) async {
    final newItem = CalculationHistory(
      expression: expression,
      result: result,
      timestamp: DateTime.now(),
    );
    
    _history.insert(0, newItem); //Đưa phép tính mới nhất lên đầu danh sách
    
    //Giới hạn 50 phép tính (hoặc theo Setting của người dùng sau này)
    if (_history.length > 50) {
      _history.removeLast();
    }
    
    await _storageService.saveHistory(_history);
    notifyListeners();
  }

  //Gọi hàm này khi người dùng muốn xóa sạch lịch sử
  Future<void> clearHistory() async {
    _history.clear();
    await _storageService.saveHistory(_history);
    notifyListeners();
  }
}
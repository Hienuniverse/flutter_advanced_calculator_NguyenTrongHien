class CalculatorLogic {
  // àm này giúp định dạng số lớn có dấu phẩy (VD: 1,000,000)
  static String formatNumber(String numberStr) {
    if (numberStr.startsWith('Error')) return numberStr;
    
    //Logic thêm dấu phẩy hàng nghìn có thể được phát triển ở đây
    //Tạm thời trả về nguyên bản
    return numberStr;
  }
}
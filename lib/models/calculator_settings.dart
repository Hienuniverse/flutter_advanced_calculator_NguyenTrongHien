class CalculatorSettings {
  final int decimalPrecision;
  final bool hapticFeedback;
  final bool soundEffects;
  final int historySize;

  CalculatorSettings({
    this.decimalPrecision = 5,
    this.hapticFeedback = true,
    this.soundEffects = false,
    this.historySize = 50,
  });
}
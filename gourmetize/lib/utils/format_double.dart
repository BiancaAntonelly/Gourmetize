String formatDouble(double value) {
  return value.toStringAsFixed(2).replaceAll(RegExp(r'([.]*0+)$'), '');
}

extension StringFormatter on String {
  String get salaryValue {
    try {
      final salary = double.parse(this);
      if (salary >= 1000 && salary < 10000) {
        double k = salary / 1000.0;
        String formatted = k.toStringAsFixed(1);
        return formatted.endsWith('.0') ? '${k.toInt()}k' : '${formatted}k';
      } else if (salary >= 10000 && salary < 1000000) {
        double k = salary / 1000.0;
        String formatted = k.toStringAsFixed(1);
        return formatted.endsWith('.0') ? '${k.toInt()}k' : '${formatted}k';
      } else {
        return salary.toString();
      }
    } catch (e, s) {
      print(e);
      print(s);
      return '';
    }
  }
}
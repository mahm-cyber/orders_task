import 'package:intl/intl.dart';

extension DoubleEx on double {
  String get toCurrency {
    final format = NumberFormat.currency(symbol: '\$');
    return format.format(this);
  }
}

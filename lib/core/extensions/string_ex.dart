import 'package:intl/intl.dart';

extension StringEx on String? {
  double get toPrice {
    double parsedAmount = double.tryParse(
            (this ?? '0').replaceAll(',', '').replaceAll('\$', '')) ??
        0;

    return parsedAmount;
  }
}

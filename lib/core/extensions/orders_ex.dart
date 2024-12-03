import '../../feature/models/order_model.dart';

extension OrdersEx on List<OrderModel> {
  Map<String, int> toMonthOrders() {
    return {
      'JAN': where((element) => element.registered?.month == 1).length,
      'FEB': where((element) => element.registered?.month == 2).length,
      'MAR': where((element) => element.registered?.month == 3).length,
      'APR': where((element) => element.registered?.month == 4).length,
      'MAY': where((element) => element.registered?.month == 5).length,
      'JUN': where((element) => element.registered?.month == 6).length,
      'JUL': where((element) => element.registered?.month == 7).length,
      'AUG': where((element) => element.registered?.month == 8).length,
      'SEP': where((element) => element.registered?.month == 9).length,
      'OCT': where((element) => element.registered?.month == 10).length,
      'NOV': where((element) => element.registered?.month == 11).length,
      'DEC': where((element) => element.registered?.month == 12).length,
    };
  }
}

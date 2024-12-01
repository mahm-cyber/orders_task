import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/order_model.dart';

class OrdersRepo {
  OrdersRepo._();

  factory OrdersRepo() => _ordersRepo;
  static final OrdersRepo _ordersRepo = OrdersRepo._();

  Future<List<OrderModel>> load() async {
    String ordersFile = 'assets/orders.json';
    final configString = await rootBundle.loadString(ordersFile);
    final List<dynamic> orders = jsonDecode(configString);

    return orders.map((e) => OrderModel.fromJson(e)).toList();
  }
}

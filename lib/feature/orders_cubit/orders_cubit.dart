import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_task/core/extensions/string_ex.dart';
import 'package:orders_task/feature/models/order_model.dart';

import '../repository/orders_repo.dart';

part 'orders_state.dart';

enum OrderStatus {
  delivered('DELIVERED'),
  ordered('ORDERED'),
  returned('RETURNED'),
  ;

  final String value;

  const OrderStatus(this.value);
}

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required OrdersRepo ordersRepo,
  })  : _ordersRepo = ordersRepo,
        super(OrdersState()) {
    loadOrders();
  }

  final OrdersRepo _ordersRepo;

  final List<OrderModel> orders = [];

  Future<void> loadOrders() async {
    emit(OrdersState(status: const MetricsLoading()));
    await Future.delayed(const Duration(seconds: 1));

    try {
      orders.addAll(await _ordersRepo.load());
      final total = orders.fold<double>(
          0, (prev, element) => prev + element.price!.toPrice);
      final avgPrice = total / orders.length;
      final returned = orders
          .where((element) => element.status == OrderStatus.returned)
          .length;
      emit(
        OrdersState(
          status: MetricsLoaded(
            orders: orders,
            total: total,
            avgPrice: avgPrice,
            returned: returned,
          ),
        ),
      );
    } catch (e) {
      print('Error: $e');
      emit(OrdersState(status: const MetricsError()));
    }
  }
}

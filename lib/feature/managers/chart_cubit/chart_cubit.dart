import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:orders_task/core/extensions/orders_ex.dart';
import 'package:orders_task/feature/models/order_model.dart';

import '../../repository/orders_repo.dart';

part 'chart_state.dart';

class ChartCubit extends Cubit<ChartState> {
  ChartCubit({
    required OrdersRepo ordersRepo,
  })  : _ordersRepo = ordersRepo,
        super(ChartState()) {
    loadChartData();
  }

  final OrdersRepo _ordersRepo;

  Future<void> loadChartData() async {
    emit(state.copyWith(status: const ChartLoading()));
    await Future.delayed(const Duration(seconds: 1));

    try {
      final orders = await _ordersRepo.load();

      final numOfOrdersPerMonth = orders.toMonthOrders();
      emit(
        state.copyWith(
          status: ChartLoaded(
            numOfOrdersPerMonth: numOfOrdersPerMonth,
          ),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: const ChartError()));
    }
  }
}

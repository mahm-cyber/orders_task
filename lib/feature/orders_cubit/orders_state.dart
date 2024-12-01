part of 'orders_cubit.dart';

class OrdersState extends Equatable {
  final MetricsStatus status;
  const OrdersState({
    this.status = const MetricsInitial(),
  });

  OrdersState copyWith({
    MetricsStatus? status,
  }) {
    return OrdersState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}

sealed class MetricsStatus extends Equatable {
  const MetricsStatus();
  @override
  List<Object> get props => [];
}

final class MetricsInitial extends MetricsStatus {
  const MetricsInitial();
}

final class MetricsLoading extends MetricsStatus {
  const MetricsLoading();
}

final class MetricsLoaded extends MetricsStatus {
  final List<OrderModel> orders;
  final double total;
  final double avgPrice;
  final int returned;

  const MetricsLoaded({
    required this.orders,
    required this.total,
    required this.avgPrice,
    required this.returned,
  });

  @override
  List<Object> get props => [orders, total, avgPrice, returned];
}

final class MetricsError extends MetricsStatus {
  const MetricsError();
}

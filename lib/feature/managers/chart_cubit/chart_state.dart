part of 'chart_cubit.dart';

class ChartState extends Equatable {
  final ChartStatus status;

  const ChartState({
    this.status = const ChartInitial(),
  });

  ChartState copyWith({
    ChartStatus? status,
  }) {
    return ChartState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}

sealed class ChartStatus extends Equatable {
  const ChartStatus();
  @override
  List<Object> get props => [];
}

final class ChartInitial extends ChartStatus {
  const ChartInitial();
}

final class ChartLoading extends ChartStatus {
  const ChartLoading();
}

final class ChartLoaded extends ChartStatus {
  final Map<String, dynamic> numOfOrdersPerMonth;
  const ChartLoaded({required this.numOfOrdersPerMonth});

  @override
  List<Object> get props => [numOfOrdersPerMonth];
}

final class ChartError extends ChartStatus {
  const ChartError();
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orders_task/core/theme/app_colors.dart';
import 'package:orders_task/feature/managers/chart_cubit/chart_cubit.dart';

import '../repository/orders_repo.dart';

class ChartView extends StatelessWidget {
  const ChartView({super.key});

  @override
  Widget build(BuildContext context) {


    // Prepare chart data
    final List<BarChartGroupData> barChartData = [];
    int xIndex = 0;
    final Map<int, String> xLabels = {};

    return BlocProvider(
      create: (context) => ChartCubit(ordersRepo: OrdersRepo()),
      child: Scaffold(
        appBar: AppBar(title: Text('Orders Chart')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ChartCubit, ChartState>(
            builder: (context, state) {
              final status = state.status;
              if (status is ChartLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (status is ChartLoaded) {
                final entries = status.numOfOrdersPerMonth.entries;
                for (var entry in entries) {
                  barChartData.add(
                    BarChartGroupData(
                      x: xIndex,
                      barRods: [
                        BarChartRodData(
                          toY: entry.value.toDouble(),
                          width: 16,
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                            colors: [
                              AppColors.contentColorBlue,
                              AppColors.contentColorCyan
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          backDrawRodData: BackgroundBarChartRodData(
                            show: true,
                            color: Colors.blue.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  );
                  xLabels[xIndex] = entry.key; // Add month/year as label
                  xIndex++;
                }
                return BarChart(
                  BarChartData(
                    maxY: 20,
                    barGroups: barChartData,
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) =>
                              Text(value.toInt().toString()),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            final label = xLabels[value.toInt()] ?? '';
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child:
                                  Text(label, style: TextStyle(fontSize: 10)),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    // borderData: FlBorderData(show: true),
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

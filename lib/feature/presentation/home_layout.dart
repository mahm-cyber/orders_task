import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/icons/bxs.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:orders_task/core/extensions/double_ex.dart';
import 'package:orders_task/feature/orders_cubit/orders_cubit.dart';
import 'package:orders_task/feature/presentation/matrices_item.dart';
import 'package:orders_task/core/extensions/string_ex.dart';

import '../repository/orders_repo.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Dashboard'),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
          create: (context) => OrdersCubit(ordersRepo: OrdersRepo()),
          child: BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              var status = state.status;
              if (status is MetricsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (status is MetricsLoaded) {
                return Center(
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.spaceEvenly,
                    runAlignment: WrapAlignment.spaceEvenly,
                    children: [
                      MatricesItem(
                        icon: Bxs.badge_dollar,
                        title: 'Total',
                        subtitle: status.total.toCurrency,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 16),
                      MatricesItem(
                        icon: Bxs.badge_check,
                        title: 'Avg Price',
                        subtitle: status.avgPrice.toCurrency,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      MatricesItem(
                        icon: Mdi.package_variant_closed_remove,
                        title: 'Returned Orders',
                        subtitle: '${status.returned}',
                        color: Colors.red,
                      ),
                    ],
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

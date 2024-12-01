import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:orders_task/feature/orders_cubit/orders_cubit.dart';

class MatricesItem extends StatelessWidget {
  const MatricesItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 64,
      ),
      color: color.withOpacity(0.1),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 200,
          minWidth: 200,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Iconify(
                icon,
                size: 40,
                color: color,
              ),
              SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

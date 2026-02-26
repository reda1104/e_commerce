import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int value;
  final String productId;
  final dynamic cubit;
  const CounterWidget({
    required this.value,
    super.key,
    required this.productId,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => cubit.decrementCounter(productId),
            icon: const Icon(Icons.remove),
          ),
          Text(value.toString()),
          IconButton(
            onPressed: () => cubit.incrementCounter(productId),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

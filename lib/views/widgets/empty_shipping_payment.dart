import 'package:e_commerce/utils/app_colors.dart';

import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/checkout_cubit/check_out_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptyShippingPayment extends StatelessWidget {
  final String title;
  const EmptyShippingPayment({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final checkOutCubit = BlocProvider.of<CheckOutCubit>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(AppRoutes.addNewCardRoute)
            .then((value) => checkOutCubit.getCheckOutData());
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Icon(Icons.add),
              Text(title, style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }
}

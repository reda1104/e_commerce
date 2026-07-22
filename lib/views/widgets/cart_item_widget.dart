import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/views/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final AddToCartModel cartItem;
  const CartItemWidget({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CartCubit>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(30),
            ),
            child: CachedNetworkImage(
              imageUrl: cartItem.product.imgUrl,
              height: 125,
              width: 125,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartItem.product.title),
                Text.rich(
                  TextSpan(
                    text: "Size: ",
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: AppColors.grey),
                    children: [
                      TextSpan(
                        text: "${cartItem.size.name}",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                BlocBuilder<CartCubit, CartState>(
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is QuantityDetailsLoaded &&
                      current.productId == cartItem.product.id,
                  builder: (context, state) {
                    if (state is QuantityDetailsLoaded) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CounterWidget(
                            value: state.quantity,
                            productId: cartItem.product.id,
                            cubit: cubit,
                          ),
                          Text(
                            "\$${(state.quantity * cartItem.product.price).toStringAsFixed(1)}",
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      );
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CounterWidget(
                          value: cartItem.quantity,
                          productId: cartItem.product.id,
                          cubit: cubit,
                          initialValue: cartItem.quantity,
                        ),
                        Text(
                          "\$${cartItem.totalPrice.toStringAsFixed(1)}",
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/views/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) =>
          current is CartLoading ||
          current is CartLoaded ||
          current is CartError,
      bloc: BlocProvider.of<CartCubit>(context),
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is CartLoaded) {
          final cartItems = state.cartItems;
          if (cartItems.isEmpty) {
            return const Center(child: Text("Cart is empty"));
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30),
                ListView.separated(
                  separatorBuilder: (context, index) => Divider(thickness: 1),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = cartItems[index];
                    return CartItemWidget(cartItem: cartItem);
                  },
                ),
                SizedBox(height: 30),
                BlocBuilder<CartCubit, CartState>(
                  bloc: BlocProvider.of<CartCubit>(context),
                  buildWhen: (previous, current) => current is SubtotalUpdated,
                  builder: (context, subtotalState) {
                    if (subtotalState is SubtotalUpdated) {
                      return Column(
                        children: [
                          totalAndSubtotalWidget(
                            context,
                            title: "Subtotal",
                            amount: subtotalState.subtotal,
                          ),
                          totalAndSubtotalWidget(
                            context,
                            title: "Shipping",
                            amount: 10,
                          ),
                          Dash(
                            dashColor: AppColors.grey,
                            length: MediaQuery.of(context).size.width * 0.8,
                          ),
                          totalAndSubtotalWidget(
                            context,
                            title: "Total",
                            amount: subtotalState.subtotal + 10,
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        totalAndSubtotalWidget(
                          context,
                          title: "Subtotal",
                          amount: state.subtotal,
                        ),
                        totalAndSubtotalWidget(
                          context,
                          title: "Shipping",
                          amount: 10,
                        ),
                        Dash(
                          dashColor: AppColors.grey,
                          length: MediaQuery.of(context).size.width * 0.8,
                        ),
                        totalAndSubtotalWidget(
                          context,
                          title: "Total",
                          amount: state.subtotal + 10,
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.checkoutRoute);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                      ),
                      child: const Text("Checkout"),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is CartError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text("Something went wrong"));
        }
      },
    );
  }

  Widget totalAndSubtotalWidget(
    context, {
    required String title,
    required double amount,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: AppColors.grey),
          ),
          Text("\$$amount", style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

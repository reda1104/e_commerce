import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/views/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: BlocBuilder<CartCubit, CartState>(
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
                ],
              ),
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text("Something went wrong"));
          }
        },
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/payment_card_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/add_new_card_cubit/payment_methods_cubit.dart';
import 'package:e_commerce/view_models/checkout_cubit/check_out_cubit.dart';
import 'package:e_commerce/views/widgets/checkout_headlines_item.dart';
import 'package:e_commerce/views/widgets/empty_shipping_payment.dart';
import 'package:e_commerce/views/widgets/payment_card_widget.dart';
import 'package:e_commerce/views/widgets/payment_method_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  Widget _buildPaymentCardItem(
    PaymentCardModel? selectedCard,
    BuildContext context,
  ) {
    if (selectedCard != null) {
      return PaymentCardWidget(
        paymentCard: selectedCard,
        OnItemTapped: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return SizedBox(
                width: double.infinity,
                child: BlocProvider(
                  create: (context) {
                    final cubit = PaymentMethodsCubit();
                    cubit.fetchPaymentMethods();
                    return cubit;
                  },
                  child: PaymentMethodBottomSheet(),
                ),
              );
            },
          );
        },
      );
    } else {
      return const EmptyShippingPayment(
        isPayment: true,
        title: "Add Payment Method",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = CheckOutCubit();
        cubit.getCheckOutData();
        return cubit;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Checkout")),
        body: Builder(
          builder: (context) {
            final cubit = BlocProvider.of<CheckOutCubit>(context);
            return BlocBuilder<CheckOutCubit, CheckOutState>(
              bloc: cubit,
              buildWhen: (previous, current) =>
                  current is CheckOutLoaded ||
                  current is CheckOutError ||
                  current is CheckOutLoading,
              builder: (context, state) {
                if (state is CheckOutLoading) {
                } else if (state is CheckOutError) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is CheckOutLoaded) {
                  final selectedPaymentCard = state.selectedCard;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          CheckoutHeadlinesItem(title: "Address", onTap: () {}),
                          SizedBox(height: 16),
                          const EmptyShippingPayment(
                            isPayment: false,
                            title: "Add Shipping Address",
                          ),
                          SizedBox(height: 16),
                          CheckoutHeadlinesItem(
                            title: "Products",
                            numOfProducts: state.numOfProducts,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.cartItems.length,
                            separatorBuilder: (context, index) =>
                                Divider(thickness: 1),
                            itemBuilder: (context, index) {
                              final cartItem = state.cartItems[index];
                              return Row(
                                children: [
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGrey,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: cartItem.product.imageUrl,
                                      height: 125,
                                      width: 125,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(cartItem.product.title),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text: "Size: ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium!
                                                    .copyWith(
                                                      color: AppColors.grey,
                                                    ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "${cartItem.size.name}",
                                                    style: Theme.of(
                                                      context,
                                                    ).textTheme.titleMedium,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Text(
                                              "\$${cartItem.totalPrice.toStringAsFixed(1)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          const CheckoutHeadlinesItem(title: "Payment"),
                          const SizedBox(height: 16),
                          _buildPaymentCardItem(selectedPaymentCard, context),
                          const SizedBox(height: 20),
                          Divider(thickness: 1),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "\$${state.totalAmount.toStringAsFixed(1)}",
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                                foregroundColor: AppColors.white,
                              ),
                              child: const Text("Proceed to Buy"),
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/add_new_card_cubit/payment_methods_cubit.dart';
import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  const PaymentMethodBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paymenMethodsCubit = BlocProvider.of<PaymentMethodsCubit>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.04),
            Text(
              "Payment Methods",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            BlocBuilder(
              bloc: paymenMethodsCubit,
              buildWhen: (previous, current) =>
                  current is FetchingPaymentMethods ||
                  current is FetchedPaymentMethods ||
                  current is FetchPaymentMethodsError,
              builder: (_, state) {
                if (state is FetchingPaymentMethods) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is FetchedPaymentMethods) {
                  final paymentCards = state.paymentCards;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: paymentCards.length,
                    itemBuilder: (context, index) => Card(
                      elevation: 0.5,
                      child: ListTile(
                        onTap: () => {
                          paymenMethodsCubit.changePaymentMethod(
                            paymentCards[index].id,
                          ),
                        },
                        leading: DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.grey,
                              width: 1.5,
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://toppng.com/uploads/preview/mastercard-logo-png-image-background-logo-mastercard-11563000929p7h8ctftya.png",
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(paymentCards[index].cardNumber),
                        subtitle: Text(paymentCards[index].cardHolderName),
                        trailing:
                            BlocBuilder<
                              PaymentMethodsCubit,
                              PaymentMethodsState
                            >(
                              bloc: paymenMethodsCubit,
                              buildWhen: (previous, current) =>
                                  current is ChosenPaymentMethod,
                              builder: (context, state) {
                                if (state is ChosenPaymentMethod) {
                                  final ChosenPaymentMethod = state.paymentCard;

                                  return Radio<String>(
                                    value: paymentCards[index].id,
                                    groupValue: ChosenPaymentMethod.id,
                                    onChanged: (value) {
                                      paymenMethodsCubit.changePaymentMethod(
                                        value!,
                                      );
                                    },
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              },
                            ),
                      ),
                    ),
                  );
                } else if (state is FetchPaymentMethodsError) {
                  return Center(child: Text(state.errorMessage));
                }
                return Center(child: Text("No Payment Methods"));
              },
            ),
            SizedBox(height: 9),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.addNewCardRoute);
              },
              child: Card(
                elevation: 0.5,
                child: ListTile(
                  leading: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color.fromARGB(255, 24, 23, 23),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(Icons.add),
                  ),
                  title: Text("Add New Card"),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            MainButton(
              text: "Confirm Payment",
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

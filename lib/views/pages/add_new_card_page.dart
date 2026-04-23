import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/add_new_card_cubit/payment_methods_cubit.dart';
import 'package:e_commerce/views/widgets/label_text_field_new_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewCardPage extends StatefulWidget {
  const AddNewCardPage({super.key});

  @override
  State<AddNewCardPage> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHodlerNameController =
      TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<PaymentMethodsCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Card")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelTextFieldNewCard(
                label: "Card Number",
                controller: _cardNumberController,
                hintText: "Enter Card Number",
                icon: Icons.credit_card,
              ),
              LabelTextFieldNewCard(
                label: "Card Holder Name",
                controller: _cardHodlerNameController,
                hintText: "Enter Card Holder Number",
                icon: Icons.person,
              ),
              LabelTextFieldNewCard(
                label: "Expiry Date",
                controller: _expiryDateController,
                hintText: "Enter Expiry Date",
                icon: Icons.date_range,
              ),
              LabelTextFieldNewCard(
                label: "CVV",
                controller: _cvvController,
                hintText: "Enter CVV",
                icon: Icons.password,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
                  listenWhen: (previous, current) =>
                      current is AddNewCardError ||
                      current is AddNewCardSuccess,
                  listener: (context, state) {
                    if (state is AddNewCardSuccess) {
                      Navigator.pop(context);
                    }
                    if (state is AddNewCardError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  bloc: cubit,
                  buildWhen: (previous, current) =>
                      current is AddNewCardLoading ||
                      current is AddNewCardError ||
                      current is AddNewCardSuccess,
                  builder: (context, state) {
                    if (state is AddNewCardLoading) {
                      return const ElevatedButton(
                        onPressed: null,
                        child: Text("Add Card"),
                      );
                    }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.addNewCard(
                            _cardHodlerNameController.text,
                            _cardNumberController.text,
                            _expiryDateController.text,
                            _cvvController.text,
                          );
                        }
                      },
                      child: const Text("Add Card"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

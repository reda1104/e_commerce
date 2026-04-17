import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/payment_card_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentCardWidget extends StatelessWidget {
  final PaymentCardModel paymentCard;
  final VoidCallback OnItemTapped;
  const PaymentCardWidget({
    super.key,
    required this.paymentCard,
    required this.OnItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: OnItemTapped,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.grey, width: 1.5),
        ),
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl:
                "https://toppng.com/uploads/preview/mastercard-logo-png-image-background-logo-mastercard-11563000929p7h8ctftya.png",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          title: Text("MasterCard"),
          subtitle: Text(paymentCard.cardNumber),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
    );
  }
}

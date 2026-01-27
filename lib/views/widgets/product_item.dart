import 'package:e_commerce/models/product_item_model.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Image.network(productItem.imageUrl, height: 120, width: 200),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.black),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        Text(productItem.title, style: Theme.of(context).textTheme.labelLarge),
        Text(
          productItem.category,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          "\$${productItem.price}",
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}

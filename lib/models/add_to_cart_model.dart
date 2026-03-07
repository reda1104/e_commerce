import 'package:e_commerce/models/product_item_model.dart';
import 'package:flutter/material.dart';

class AddToCartModel {
  final String id;
  final ProductItemModel product;
  final ProductSizes size;
  final int quantity;

  AddToCartModel({
    required this.id,
    required this.product,
    required this.size,
    required this.quantity,
  });

  double get totalPrice {
    return product.price * quantity;
  }

  AddToCartModel copyWith({
    String? id,
    ProductItemModel? product,
    ProductSizes? size,
    int? quantity,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}

List<AddToCartModel> dummyCart = [];

import 'package:e_commerce/models/product_item_model.dart';
import 'package:flutter/material.dart';

class AddToCartModel {
  final String productId;
  final ProductSizes size;
  final int quantity;

  AddToCartModel({
    required this.productId,
    required this.size,
    required this.quantity,
  });

  AddToCartModel copyWith({
    String? productId,
    ProductSizes? size,
    int? quantity,
  }) {
    return AddToCartModel(
      productId: productId ?? this.productId,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}

List<AddToCartModel> dummyCart = [];

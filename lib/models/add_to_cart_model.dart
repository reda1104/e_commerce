// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:e_commerce/models/product_item_model.dart';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'product': product.toMap(),
      'size': size.name,
      'quantity': quantity,
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      id: map['id'] as String,
      product: ProductItemModel.fromMap(map['product'] as Map<String, dynamic>),
      size: ProductSizes.fromString(map['size']),
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddToCartModel.fromJson(String source) =>
      AddToCartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<AddToCartModel> dummyCart = [];

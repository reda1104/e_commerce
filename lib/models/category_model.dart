import 'package:flutter/material.dart';

import 'package:e_commerce/utils/app_colors.dart';

class CategoryModel {
  final String id;
  final String name;
  final int productCount;
  final Color bgColor;
  final Color textColor;

  CategoryModel({
    required this.id,
    required this.name,
    required this.productCount,
    this.bgColor = AppColors.primary,
    this.textColor = AppColors.white,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'productCount': productCount,
      'bgColor': bgColor.value,
      'textColor': textColor.value,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      productCount: map['productCount'] as int,
      bgColor: Color(map['bgColor'] as int),
      textColor: Color(map['textColor'] as int),
    );
  }
}

List<CategoryModel> dummyCategories = [
  CategoryModel(
    id: '1',
    name: 'Electronics',
    productCount: 120,
    bgColor: const Color(0xFF9E9E9E),
    textColor: const Color(0xFF000000),
  ),
  CategoryModel(
    id: '2',
    name: 'Fashion',
    productCount: 85,
    bgColor: Colors.pink.shade200,
    textColor: Colors.white,
  ),
  CategoryModel(
    id: '3',
    name: 'Home & Kitchen',
    productCount: 60,
    bgColor: Colors.orange.shade200,
    textColor: Colors.black,
  ),
  CategoryModel(
    id: '4',
    name: 'Books',
    productCount: 40,
    bgColor: Colors.green.shade200,
    textColor: Colors.white,
  ),
  CategoryModel(
    id: '5',
    name: 'Sports',
    productCount: 30,
    bgColor: Colors.purple.shade200,
    textColor: Colors.white,
  ),
];

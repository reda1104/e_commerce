import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

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
}

List<CategoryModel> dummyCategories = [
  CategoryModel(
    id: '1',
    name: 'Electronics',
    productCount: 120,
    bgColor: AppColors.grey,
    textColor: AppColors.black,
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

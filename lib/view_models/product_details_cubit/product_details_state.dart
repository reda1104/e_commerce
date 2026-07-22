part of 'product_details_cubit.dart';

sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel product;
  ProductDetailsLoaded({required this.product});
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError({required this.message});
}

final class ProductAddedToCart extends ProductDetailsState {
  final String productId;
  ProductAddedToCart({required this.productId});
}

final class ProductAddingToCart extends ProductDetailsState {}

final class ProductAddingToCartError extends ProductDetailsState {
  final String message;
  ProductAddingToCartError({required this.message});
}

final class QuantityDetailsLoaded extends ProductDetailsState {
  final int quantity;
  QuantityDetailsLoaded({required this.quantity});
}

final class SizeSelected extends ProductDetailsState {
  final ProductSizes size;
  SizeSelected({required this.size});
}

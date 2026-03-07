part of 'cart_cubit.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItems;
  final double subtotal;
  CartLoaded({required this.cartItems, required this.subtotal});
}

final class CartError extends CartState {
  final String message;
  CartError({required this.message});
}

final class QuantityDetailsLoaded extends CartState {
  final int quantity;
  final String productId;
  QuantityDetailsLoaded({required this.productId, required this.quantity});
}

final class SubtotalUpdated extends CartState {
  final double subtotal;
  SubtotalUpdated({required this.subtotal});
}

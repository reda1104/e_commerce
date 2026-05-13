part of 'check_out_cubit.dart';

sealed class CheckOutState {}

final class CheckOutInitial extends CheckOutState {}

final class CheckOutLoading extends CheckOutState {}

final class CheckOutLoaded extends CheckOutState {
  final List<AddToCartModel> cartItems;
  final double totalAmount;
  final int numOfProducts;
  final PaymentCardModel? selectedCard;
  final LocationItemModel? chosenLocation;
  CheckOutLoaded({
    required this.cartItems,
    required this.totalAmount,
    required this.numOfProducts,
    this.selectedCard,
    this.chosenLocation,
  });
}

final class CheckOutError extends CheckOutState {
  final String errorMessage;
  CheckOutError({required this.errorMessage});
}

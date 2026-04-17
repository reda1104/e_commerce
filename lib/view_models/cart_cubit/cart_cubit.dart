import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;

  void getCartItems() {
    emit(CartLoading());
    emit(CartLoaded(cartItems: dummyCart, subtotal: _subtotal));
  }

  void incrementCounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }

    final index = dummyCart.indexWhere(
      (element) => element.product.id == productId,
    );
    dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
    quantity++;
    emit(QuantityDetailsLoaded(quantity: quantity, productId: productId));
    emit(SubtotalUpdated(subtotal: _subtotal));
  }

  void decrementCounter(String productId, [int? initialValue]) {
    if (initialValue != null) {
      quantity = initialValue;
    }

    final index = dummyCart.indexWhere(
      (element) => element.product.id == productId,
    );
    dummyCart[index] = dummyCart[index].copyWith(quantity: quantity);
    quantity--;
    emit(QuantityDetailsLoaded(quantity: quantity, productId: productId));
    emit(SubtotalUpdated(subtotal: _subtotal));
  }

  double get _subtotal => dummyCart.fold<double>(
    0,
    (previousValue, element) =>
        previousValue + element.product.price * element.quantity,
  );
}

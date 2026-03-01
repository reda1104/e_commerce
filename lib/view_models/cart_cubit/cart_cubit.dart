import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  int quantity = 1;

  void getCartItems() {
    emit(CartLoading());
    emit(CartLoaded(cartItems: dummyCart));
  }

  void incrementCounter(String productId) {
    quantity++;
    emit(QuantityDetailsLoaded(quantity: quantity));
  }

  void decrementCounter(String productId) {
    quantity--;
    emit(QuantityDetailsLoaded(quantity: quantity));
  }
}

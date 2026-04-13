import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';
part 'check_out_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit() : super(CheckOutInitial());

  void getCheckOutData() {
    emit(CheckOutLoading());
    final subTotal = dummyCart.fold(
      0.0,
      (previousValue, element) =>
          previousValue + element.product.price * element.quantity,
    );
    final numOfProducts = dummyCart.fold(
      0,
      (previousValue, element) => previousValue + element.quantity,
    );
    Future.delayed(const Duration(seconds: 1), () {
      emit(
        CheckOutLoaded(
          cartItems: dummyCart,
          totalAmount: subTotal + 10,
          numOfProducts: numOfProducts,
        ),
      );
    });
  }
}

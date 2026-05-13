import 'package:e_commerce/models/location_item_model.dart';
import 'package:e_commerce/models/payment_card_model.dart';
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
      final PaymentCardModel? paymentCard = dummyCards.isNotEmpty
          ? dummyCards.first
          : null;
      final chosenLocation = dummyLocations.firstWhere(
        (element) => element.isChosen == true,
        orElse: () => dummyLocations.first,
      );
      emit(
        CheckOutLoaded(
          cartItems: dummyCart,
          totalAmount: subTotal + 10,
          numOfProducts: numOfProducts,
          selectedCard: paymentCard,
          chosenLocation: chosenLocation,
        ),
      );
    });
  }
}

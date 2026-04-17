import 'package:e_commerce/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_new_card_state.dart';

class AddNewCardCubit extends Cubit<AddNewCardState> {
  AddNewCardCubit() : super(AddNewCardInitial());

  void addNewCard(
    String cardHolderName,
    String cardNumber,
    String expiryDate,
    String cvv,
  ) {
    emit(AddNewCardLoading());

    final newCard = PaymentCardModel(
      id: DateTime.now().toIso8601String(),
      cardHolderName: cardHolderName,
      cardNumber: cardNumber,
      expiryDate: expiryDate,
      cvv: cvv,
    );
    Future.delayed(const Duration(seconds: 1), () {
      dummyCards.add(newCard);
      emit(AddNewCardSuccess());
    });
  }
}

import 'package:e_commerce/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());

  String? selectedPaymentid;

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

  void fetchPaymentMethods() {
    emit(FetchingPaymentMethods());
    Future.delayed(const Duration(seconds: 1), () {
      if (dummyCards.isNotEmpty) {
        emit(FetchedPaymentMethods(paymentCards: dummyCards));
        emit(ChosenPaymentMethod(paymentCard: dummyCards.first));
      } else {
        emit(FetchPaymentMethodsError(errorMessage: "No Payment Methods"));
      }
    });
  }

  void changePaymentMethod(String id) {
    selectedPaymentid = id;
  }

  void confirmPaymentMethod() {
    var chosenPaymentMethod = dummyCards.firstWhere(
      (element) => element.id == selectedPaymentid,
    );
    var previousChosenPaymentMethod = dummyCards.firstWhere(
      (element) => element.isChosen == true,
      orElse: () => dummyCards.first,
    );
    previousChosenPaymentMethod = previousChosenPaymentMethod.copyWith(
      isChosen: false,
    );
    chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);
    emit(ChosenPaymentMethod(paymentCard: chosenPaymentMethod));
  }
}

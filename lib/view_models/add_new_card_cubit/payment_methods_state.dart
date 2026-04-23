part of 'payment_methods_cubit.dart';

sealed class PaymentMethodsState {}

final class PaymentMethodsInitial extends PaymentMethodsState {}

final class AddNewCardLoading extends PaymentMethodsState {}

final class AddNewCardSuccess extends PaymentMethodsState {}

final class AddNewCardError extends PaymentMethodsState {
  final String errorMessage;
  AddNewCardError({required this.errorMessage});
}

final class FetchingPaymentMethods extends PaymentMethodsState {}

final class FetchedPaymentMethods extends PaymentMethodsState {
  final List<PaymentCardModel> paymentCards;
  FetchedPaymentMethods({required this.paymentCards});
}

final class FetchPaymentMethodsError extends PaymentMethodsState {
  final String errorMessage;
  FetchPaymentMethodsError({required this.errorMessage});
}

final class ChosenPaymentMethod extends PaymentMethodsState {
  final PaymentCardModel paymentCard;
  ChosenPaymentMethod({required this.paymentCard});
}

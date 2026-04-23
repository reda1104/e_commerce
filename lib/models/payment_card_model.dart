// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvv;
  final bool isChosen;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    this.isChosen = false,
  });

  PaymentCardModel copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    String? cvv,
    bool? isChosen,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      cvv: cvv ?? this.cvv,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<PaymentCardModel> dummyCards = [
  PaymentCardModel(
    id: "1",
    cardHolderName: "Mohamed Reda",
    cardNumber: "1234 1234 1234 1234",
    expiryDate: "01/24",
    cvv: "123",
  ),
  PaymentCardModel(
    id: "2",
    cardHolderName: "John Doe",
    cardNumber: "1234 1234 1234 1234",
    expiryDate: "01/24",
    cvv: "123",
  ),
  PaymentCardModel(
    id: "3",
    cardHolderName: "Tim parker",
    cardNumber: "1234 1234 1234 1234",
    expiryDate: "01/24",
    cvv: "123",
  ),
];

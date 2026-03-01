import 'package:bloc/bloc.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductSizes? selectedSize;
  int quantity = 1;

  void getProductDetails(String id) {
    emit(ProductDetailsLoading());
    Future.delayed(const Duration(seconds: 1), () {
      final selectedProduct = dummyProducts.firstWhere(
        (element) => element.id == id,
      );
      emit(ProductDetailsLoaded(product: selectedProduct));
    });
  }

  void selectSize(ProductSizes size) {
    selectedSize = size;
    emit(SizeSelected(size: size));
  }

  void addToCart(String productId) {
    emit(ProductAddingToCart());
    final cartItem = AddToCartModel(
      id: DateTime.now().toIso8601String(),
      product: dummyProducts.firstWhere((element) => element.id == productId),
      size: selectedSize!,
      quantity: quantity,
    );
    dummyCart.add(cartItem);
    Future.delayed(const Duration(seconds: 1), () {
      emit(ProductAddedToCart(productId: productId));
    });
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

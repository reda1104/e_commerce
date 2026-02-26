import 'package:bloc/bloc.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/product_item_model.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  late ProductSizes selectedSize;
  late int quantity;

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
    emit(ProductDetailsLoading());
    final cartItem = AddToCartModel(
      productId: productId,
      size: selectedSize,
      quantity: quantity,
    );
    dummyCart.add(cartItem);
    Future.delayed(const Duration(seconds: 1), () {
      emit(ProductAddedToCart(productId: productId));
    });
  }

  void incrementCounter(String productId) {
    final selectedItem = dummyProducts.indexWhere(
      (element) => element.id == productId,
    );
    dummyProducts[selectedItem] = dummyProducts[selectedItem].copyWith(
      quantity: dummyProducts[selectedItem].quantity + 1,
    );
    quantity = dummyProducts[selectedItem].quantity;
    emit(QuantityDetailsLoaded(quantity: dummyProducts[selectedItem].quantity));
  }

  void decrementCounter(String productId) {
    final selectedItem = dummyProducts.indexWhere(
      (element) => element.id == productId,
    );
    dummyProducts[selectedItem] = dummyProducts[selectedItem].copyWith(
      quantity: dummyProducts[selectedItem].quantity - 1,
    );
    quantity = dummyProducts[selectedItem].quantity;
    emit(QuantityDetailsLoaded(quantity: dummyProducts[selectedItem].quantity));
  }
}

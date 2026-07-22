import 'package:bloc/bloc.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/product_details_services.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  ProductSizes? selectedSize;
  int quantity = 1;
  final productDetailsServices = ProductDetailsServicesImpl();
  final authServices = AuthServicesImpl();
  void getProductDetails(String id) async {
    emit(ProductDetailsLoading());

    try {
      final product = await productDetailsServices.fetchProductDetails(id);
      emit(ProductDetailsLoaded(product: product));
    } catch (e) {
      emit(ProductDetailsError(message: e.toString()));
    }

    // emit(ProductDetailsLoading());
    // Future.delayed(const Duration(seconds: 1), () {
    //   final selectedProduct = dummyProducts.firstWhere(
    //     (element) => element.id == id,
    //   );
    //   emit(ProductDetailsLoaded(product: selectedProduct));
    // });
  }

  void selectSize(ProductSizes size) {
    selectedSize = size;
    emit(SizeSelected(size: size));
  }

  Future<void> addToCart(String productId) async {
    final currentUser = authServices.currentUser();
    emit(ProductAddingToCart());
    try {
      final product = await productDetailsServices.fetchProductDetails(
        productId,
      );
      final cartItem = AddToCartModel(
        id: DateTime.now().toIso8601String(),
        product: product,
        size: selectedSize!,
        quantity: quantity,
      );
      await productDetailsServices.addToCart(cartItem, currentUser!.uid);
      emit(ProductAddedToCart(productId: productId));
    } catch (e) {
      emit(ProductAddingToCartError(message: e.toString()));
    }
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

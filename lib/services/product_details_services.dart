import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';

abstract class ProductDetailsServices {
  Future<ProductItemModel> fetchProductDetails(String productId);
  Future<void> addToCart(AddToCartModel cartItem, String userId);
}

final firestore = FirestoreServices.instance;

class ProductDetailsServicesImpl implements ProductDetailsServices {
  @override
  Future<ProductItemModel> fetchProductDetails(String productId) async {
    final result = await firestore.getDocument<ProductItemModel>(
      path: ApiPaths.product(productId),
      builder: (data, documentId) => ProductItemModel.fromMap(data!),
    );
    return result;
  }

  @override
  Future<void> addToCart(AddToCartModel cartItem, String userId) async =>
      await firestore.setData(
        path: ApiPaths.cartItem(userId, cartItem.id),
        data: cartItem.toMap(),
      );
}

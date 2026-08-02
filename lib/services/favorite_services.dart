import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';

abstract class FavoriteServices {
  Future<void> addFavoriteProduct(ProductItemModel product, String userId);
  Future<void> removeFavoriteProduct(String productId, String userId);
  Future<List<ProductItemModel>> fetchFavoriteProducts(String userId);
}

class FavoriteServicesImpl extends FavoriteServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<void> addFavoriteProduct(
    ProductItemModel product,
    String userId,
  ) async {
    await firestoreServices.setData(
      path: ApiPaths.favoriteProduct(userId, product.id),
      data: product.toMap(),
    );
  }

  @override
  Future<List<ProductItemModel>> fetchFavoriteProducts(String userId) async {
    final result = await firestoreServices.getCollection<ProductItemModel>(
      path: ApiPaths.favoriteProducts(userId),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<void> removeFavoriteProduct(String productId, String userId) async {
    await firestoreServices.deleteData(
      path: ApiPaths.favoriteProduct(userId, productId),
    );
  }
}

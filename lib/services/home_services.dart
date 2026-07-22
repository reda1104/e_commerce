import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/home_carousel_item_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> fetchProducts();
  Future<List<HomeCarouselItemModel>> fetchHomeCarouselItems();
  Future<List<CategoryModel>> fetchCategories();
  Future<List<ProductItemModel>> fetchFavoriteProducts(String userId);
  Future<void> addFavoriteProduct({
    required ProductItemModel product,
    required String userId,
  });
  Future<void> removeFavoriteProduct({
    required String productId,
    required String userId,
  });
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FirestoreServices.instance;

  @override
  Future<List<ProductItemModel>> fetchProducts() async {
    final result = await firestoreServices.getCollection<ProductItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final result = await firestoreServices.getCollection<CategoryModel>(
      path: ApiPaths.categories(),
      builder: (data, documentId) => CategoryModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<List<HomeCarouselItemModel>> fetchHomeCarouselItems() async {
    final result = await firestoreServices.getCollection<HomeCarouselItemModel>(
      path: ApiPaths.announcements(),
      builder: (data, documentId) => HomeCarouselItemModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<void> addFavoriteProduct({
    required ProductItemModel product,
    required String userId,
  }) async {
    // TODO: implement addFavoriteProduct
    await firestoreServices.setData(
      path: ApiPaths.favoriteProduct(userId, product.id),
      data: product.toMap(),
    );
  }

  @override
  Future<void> removeFavoriteProduct({
    required String productId,
    required String userId,
  }) async {
    // TODO: implement removeFavoriteProduct
    await firestoreServices.deleteData(
      path: ApiPaths.favoriteProduct(userId, productId),
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
}

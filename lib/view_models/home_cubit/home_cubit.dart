import 'package:e_commerce/models/home_carousel_item_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/favorite_services.dart';
import 'package:e_commerce/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServicesImpl();
  final favoriteServices = FavoriteServicesImpl();
  final authServices = AuthServicesImpl();
  List<ProductItemModel> _products = [];
  List<HomeCarouselItemModel> _carouselItems = [];

  void getHomeData() async {
    emit(HomeLoading());
    try {
      final currentUser = authServices.currentUser();
      final products = await homeServices.fetchProducts();
      final homeCarouselItems = await homeServices.fetchHomeCarouselItems();
      final favoriteProducts = await favoriteServices.fetchFavoriteProducts(
        currentUser!.uid,
      );
      final finalProducts = products.map((product) {
        final isFavorite = favoriteProducts.any(
          (element) => element.id == product.id,
        );
        return product.copyWith(isFavorite: isFavorite);
      }).toList();

      _products = finalProducts;
      _carouselItems = homeCarouselItems;

      emit(HomeLoaded(products: _products, homeCarouselItems: _carouselItems));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> setFavorite(ProductItemModel product) async {
    try {
      final currentUser = authServices.currentUser();

      if (product.isFavorite) {
        await favoriteServices.removeFavoriteProduct(
          product.id,
          currentUser!.uid,
        );
      } else {
        await favoriteServices.addFavoriteProduct(product, currentUser!.uid);
      }

      _products = _products.map((p) {
        if (p.id == product.id) {
          return p.copyWith(isFavorite: !p.isFavorite);
        }
        return p;
      }).toList();

      emit(HomeLoaded(products: _products, homeCarouselItems: _carouselItems));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}

import 'package:e_commerce/models/home_carousel_item_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final homeServices = HomeServicesImpl();
  final authServices = AuthServicesImpl();

  void getHomeData() async {
    emit(HomeLoading());
    try {
      final products = await homeServices.fetchProducts();
      final homeCarouselItems = await homeServices.fetchHomeCarouselItems();
      emit(
        HomeLoaded(homeCarouselItems: homeCarouselItems, products: products),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> setFavorite(ProductItemModel product) async {
    emit(SetFavoriteLoading());
    try {
      final currentUser = authServices.currentUser();
      final favoriteProducts = await homeServices.fetchFavoriteProducts(
        currentUser!.uid,
      );
      final isFavorite = favoriteProducts.any(
        (element) => element.id == product.id,
      );
      if (isFavorite) {
        await homeServices.removeFavoriteProduct(
          productId: product.id,
          userId: currentUser.uid,
        );
      } else {
        await homeServices.addFavoriteProduct(
          product: product,
          userId: currentUser.uid,
        );
      }
      emit(SetFavoriteSuccess(isFavorite: !isFavorite));
    } catch (e) {
      emit(SetFavoriteError(e.toString()));
    }
  }
}

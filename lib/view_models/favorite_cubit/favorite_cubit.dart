import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/favorite_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  final favoriteServices = FavoriteServicesImpl();
  final authServices = AuthServicesImpl();
  Future<void> getFavoriteProducts() async {
    emit(FavoriteLoading());
    try {
      final userId = authServices.currentUser()!.uid;
      final products = await favoriteServices.fetchFavoriteProducts(userId);
      emit(FavoriteLoaded(favoriteProducts: products));
    } catch (e) {
      emit(FavoriteError(e.toString()));
    }
  }

  Future<void> removeFavorite(String productId) async {
    emit(FavoriteRemoving(productId));
    try {
      final userId = authServices.currentUser()!.uid;
      await favoriteServices.removeFavoriteProduct(productId, userId);
      emit(FavoriteRemoved(productId));
      final products = await favoriteServices.fetchFavoriteProducts(userId);
      emit(FavoriteLoaded(favoriteProducts: products));
    } catch (e) {
      emit(FavoriteRemoveError(e.toString()));
    }
  }
}

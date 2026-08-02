part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<HomeCarouselItemModel> homeCarouselItems;
  final List<ProductItemModel> products;
  HomeLoaded({required this.homeCarouselItems, required this.products});
}

final class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

final class SetFavoriteLoading extends HomeState {
  final String productId;

  SetFavoriteLoading(this.productId);
}

final class SetFavoriteSuccess extends HomeState {
  final bool isFavorite;
  final String productId;
  SetFavoriteSuccess({required this.productId, required this.isFavorite});
}

final class SetFavoriteError extends HomeState {
  SetFavoriteError(this.message, this.productId);
  final String message;
  final String productId;
}

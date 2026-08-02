import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      bloc: favoriteCubit,
      buildWhen: (previous, current) =>
          current is FavoriteLoading ||
          current is FavoriteLoaded ||
          current is FavoriteError,
      builder: (context, state) {
        if (state is FavoriteLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is FavoriteLoaded) {
          final favoriteProducts = state.favoriteProducts;
          if (state.favoriteProducts.isEmpty) {
            return const Center(child: Text("No favorite products"));
          }
          return RefreshIndicator(
            onRefresh: favoriteCubit.getFavoriteProducts,
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  const Divider(indent: 20, endIndent: 20),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return ListTile(
                  title: Text(product.title),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.imgUrl),
                    radius: 30,
                  ),
                  subtitle: Text(product.price.toString()),
                  trailing: BlocConsumer<FavoriteCubit, FavoriteState>(
                    listenWhen: (previous, current) =>
                        current is FavoriteRemoveError,
                    listener: (context, state) {
                      if (state is FavoriteRemoveError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                    },
                    bloc: favoriteCubit,
                    buildWhen: (previous, current) =>
                        (current is FavoriteRemoved &&
                            current.productId == product.id) ||
                        current is FavoriteRemoveError ||
                        (current is FavoriteRemoving &&
                            current.productId == product.id),
                    builder: (context, state) {
                      if (state is FavoriteRemoving) {
                        return const CircularProgressIndicator.adaptive();
                      }
                      return IconButton(
                        icon: Icon(Icons.delete, color: AppColors.red),
                        onPressed: () async {
                          await favoriteCubit.removeFavorite(product.id);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          );
        } else if (state is FavoriteError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

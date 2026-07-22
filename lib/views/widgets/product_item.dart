import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItem extends StatelessWidget {
  final ProductItemModel productItem;
  const ProductItem({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Column(
      children: [
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: productItem.imgUrl,
                height: 110,
                width: 200,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              // Image.network(productItem.imageUrl, height: 120, width: 200),
              Positioned(
                top: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white54,
                    ),
                    child: BlocBuilder<HomeCubit, HomeState>(
                      bloc: homeCubit,
                      buildWhen: (previous, current) =>
                          current is SetFavoriteLoading ||
                          current is SetFavoriteSuccess ||
                          current is SetFavoriteError,
                      builder: (context, state) {
                        if (state is SetFavoriteLoading) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else if (state is SetFavoriteSuccess) {
                          return state.isFavorite
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () async {
                                    await homeCubit.setFavorite(productItem);
                                  },
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.black,
                                  ),
                                  onPressed: () async {
                                    await homeCubit.setFavorite(productItem);
                                  },
                                );
                        }
                        return IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.black,
                          ),
                          onPressed: () async {
                            await homeCubit.setFavorite(productItem);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(productItem.title, style: Theme.of(context).textTheme.labelLarge),
        Text(
          productItem.category,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          "\$${productItem.price}",
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}

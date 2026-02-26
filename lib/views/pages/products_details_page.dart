import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:e_commerce/views/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsDetailsPage extends StatelessWidget {
  final String productId;
  const ProductsDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: BlocProvider.of<ProductDetailsCubit>(context),
      buildWhen: (previous, current) =>
          current is! QuantityDetailsLoaded && current is! SizeSelected,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return Scaffold(
            body: const Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (state is ProductDetailsError) {
          return Scaffold(body: Center(child: Text(state.message)));
        } else if (state is ProductDetailsLoaded) {
          final product = state.product;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text("Product Details"),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
              ],
            ),
            body: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.lightGrey,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 100),
                      CachedNetworkImage(
                        fit: BoxFit.contain,
                        imageUrl: product.imageUrl,
                        height: size.height * 0.4,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.48),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: AppColors.yellow),
                                      SizedBox(width: 3),
                                      Text(product.averageRate.toString()),
                                    ],
                                  ),
                                ],
                              ),
                              BlocBuilder<
                                ProductDetailsCubit,
                                ProductDetailsState
                              >(
                                bloc: BlocProvider.of<ProductDetailsCubit>(
                                  context,
                                ),
                                buildWhen: (previous, current) =>
                                    current is ProductDetailsLoaded ||
                                    current is QuantityDetailsLoaded,
                                builder: (context, state) {
                                  if (state is QuantityDetailsLoaded) {
                                    return CounterWidget(
                                      value: state.quantity,
                                      productId: productId,
                                      cubit:
                                          BlocProvider.of<ProductDetailsCubit>(
                                            context,
                                          ),
                                    );
                                  } else if (state is ProductDetailsLoaded) {
                                    return CounterWidget(
                                      value: state.product.quantity,
                                      productId: productId,
                                      cubit:
                                          BlocProvider.of<ProductDetailsCubit>(
                                            context,
                                          ),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Sizes",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 4),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            bloc: BlocProvider.of<ProductDetailsCubit>(context),
                            buildWhen: (previous, current) =>
                                current is SizeSelected ||
                                current is ProductDetailsLoaded,
                            builder: (context, state) {
                              return Row(
                                children: ProductSizes.values
                                    .map(
                                      (size) => Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8.0,
                                        ),
                                        child: InkWell(
                                          onTap: () =>
                                              BlocProvider.of<
                                                    ProductDetailsCubit
                                                  >(context)
                                                  .selectSize(size),
                                          child: SizedBox(
                                            height: 44,
                                            width: 44,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    state is SizeSelected &&
                                                        state.size == size
                                                    ? Theme.of(
                                                        context,
                                                      ).primaryColor
                                                    : AppColors.lightGrey,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  12.0,
                                                ),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    size.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                          height: 1,
                                                          color:
                                                              state
                                                                      is SizeSelected &&
                                                                  state.size ==
                                                                      size
                                                              ? Colors.white
                                                              : AppColors
                                                                    .darkGrey,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                            },
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Description",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          SizedBox(height: 16),
                          Text(
                            product.description,
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: AppColors.darkGrey),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: "\$",
                                  style: Theme.of(context).textTheme.titleLarge!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                  children: [
                                    TextSpan(
                                      text: "${product.price}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                ),
                                onPressed: () {},
                                label: Text(
                                  "Add to cart",
                                  style: TextStyle(color: Colors.white),
                                ),
                                icon: Icon(
                                  Icons.shopping_bag_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(body: Center(child: Text("something went wrong!")));
        }
      },
    );
  }
}

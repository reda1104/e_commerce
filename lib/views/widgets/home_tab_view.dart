import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_router.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/home_cubit/home_cubit.dart';
import 'package:e_commerce/views/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: BlocProvider.of<HomeCubit>(context),
      buildWhen: (previous, current) =>
          current is HomeLoading ||
          current is HomeLoaded ||
          current is HomeError,
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is HomeLoaded) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "View all",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                FlutterCarousel.builder(
                  options: FlutterCarouselOptions(
                    height: 200,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    showIndicator: true,
                    slideIndicator: CircularSlideIndicator(),
                  ),
                  itemCount: state.homeCarouselItems.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: state.homeCarouselItems[index].imgUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      // child: Image.network(
                      //   dummyHomeCarouselItems[index].imgUrl,
                      //   fit: BoxFit.cover,
                      //   width: double.infinity,
                      // ),
                    );
                  },
                ),
                SizedBox(height: 40),

                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () =>
                          Navigator.of(context, rootNavigator: true).pushNamed(
                            AppRoutes.productDetailsRoute,
                            arguments: state.products[index].id,
                          ),
                      child: ProductItem(productItem: state.products[index]),
                    );
                  },
                ),
              ],
            ),
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        } else {
          throw Exception("Unknown state");
        }
      },
    );
  }
}

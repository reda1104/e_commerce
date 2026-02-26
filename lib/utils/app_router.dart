import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/product_details_cubit/product_details_cubit.dart';
import 'package:e_commerce/views/pages/custom_bottom_navbar.dart';
import 'package:e_commerce/views/pages/products_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const CustomBottomNavbar(),
          settings: settings,
        );
      case AppRoutes.productDetailsRoute:
        final String productId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) {
              final cubit = ProductDetailsCubit();
              cubit.getProductDetails(productId);
              return cubit;
            },
            child: ProductsDetailsPage(productId: productId),
          ),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}")),
          ),
        );
    }
  }
}

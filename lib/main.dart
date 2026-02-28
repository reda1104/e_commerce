import 'package:e_commerce/utils/app_router.dart';
import 'package:e_commerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/view_models/home_cubit/home_cubit.dart';
import 'package:e_commerce/views/pages/custom_bottom_navbar.dart';
import 'package:e_commerce/views/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-commerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final cubit = HomeCubit();
              cubit.getHomeData();
              return cubit;
            },
          ),
          BlocProvider(
            create: (context) {
              final cubit = CartCubit();
              cubit.getCartItems();
              return cubit;
            },
          ),
        ],
        child: CustomBottomNavbar(),
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}

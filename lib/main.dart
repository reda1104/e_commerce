import 'package:e_commerce/utils/app_router.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:e_commerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/view_models/favorite_cubit/favorite_cubit.dart';
import 'package:e_commerce/view_models/home_cubit/home_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) {
            final cubit = AuthCubit();
            cubit.checkAuth();
            return cubit;
          },
        ),
        BlocProvider<HomeCubit>(
          create: (_) {
            final cubit = HomeCubit();
            cubit.getHomeData();
            return cubit;
          },
        ),
        BlocProvider<CartCubit>(
          create: (_) {
            final cubit = CartCubit();
            cubit.getCartItems();
            return cubit;
          },
        ),
        BlocProvider<FavoriteCubit>(
          create: (_) {
            final cubit = FavoriteCubit();
            cubit.getFavoriteProducts();
            return cubit;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>
          current is AuthDone || current is AuthInitial,
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: state is AuthDone ? AppRoutes.home : AppRoutes.login,
          onGenerateRoute: AppRouter.onGenerateRoute,
        );
      },
    );
  }
}

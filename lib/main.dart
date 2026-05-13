import 'package:e_commerce/utils/app_router.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:e_commerce/view_models/cart_cubit/cart_cubit.dart';
import 'package:e_commerce/view_models/home_cubit/home_cubit.dart';
import 'package:e_commerce/views/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = AuthCubit();
        cubit.checkAuth();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          final authCubit = BlocProvider.of<AuthCubit>(context);
          return BlocBuilder<AuthCubit, AuthState>(
            bloc: authCubit,
            buildWhen: (previous, current) =>
                current is AuthDone || current is AuthInitial,
            builder: (context, state) {
              return MaterialApp(
                initialRoute: state is AuthDone
                    ? AppRoutes.home
                    : AppRoutes.login,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: AppRouter.onGenerateRoute,
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: cubit,
          listenWhen: (previous, current) =>
              current is AuthLoggedout || current is AuthLogoutError,
          listener: (context, state) {
            if (state is AuthLoggedout) {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
            } else if (state is AuthLogoutError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          buildWhen: (previous, current) => current is AuthLoggingout,
          builder: (context, state) {
            if (state is AuthLoggingout) {
              return Center(child: const CircularProgressIndicator.adaptive());
            }
            return MainButton(
              text: "Logout",
              onTap: () async {
                await cubit.logout();
              },
            );
          },
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/utils/app_routes.dart';
import 'package:e_commerce/view_models/auth_cubit/auth_cubit.dart';
import 'package:e_commerce/views/widgets/label_text_field.dart';
import 'package:e_commerce/views/widgets/main_button.dart';
import 'package:e_commerce/views/widgets/social_media_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "Create your account to start shopping",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(color: AppColors.grey),
                  ),
                  SizedBox(height: 16),
                  LabelTextField(
                    label: "Username",
                    obsecureText: true,
                    controller: userNameController,
                    hintText: "Enter Username",
                    prefixIcon: Icons.password,
                  ),
                  LabelTextField(
                    label: "Email",
                    controller: emailController,
                    hintText: "Enter Email",
                    prefixIcon: Icons.email,
                  ),

                  LabelTextField(
                    label: "Password",
                    obsecureText: true,
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.visibility),
                    ),
                    controller: passwordController,
                    hintText: "Enter Password",
                    prefixIcon: Icons.password,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text("Forgot password?"),
                    ),
                  ),
                  SizedBox(height: 24),
                  BlocConsumer<AuthCubit, AuthState>(
                    bloc: cubit,
                    listenWhen: (previous, current) =>
                        current is AuthDone || current is AuthError,
                    listener: (context, state) {
                      if (state is AuthDone) {
                        Navigator.of(context).pushNamed(AppRoutes.home);
                      } else if (state is AuthError) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      }
                      // TODO: implement listener
                    },
                    buildWhen: (previous, current) =>
                        current is AuthLoading ||
                        current is AuthError ||
                        current is AuthDone,
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return MainButton(
                        text: "Register",
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            await cubit.register(
                              emailController.text,
                              passwordController.text,
                              userNameController.text,
                            );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("You have an account? Login"),
                        ),
                        Text(
                          "Or using other methods",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: AppColors.grey),
                        ),
                        SizedBox(height: 16),
                        BlocConsumer<AuthCubit, AuthState>(
                          bloc: cubit,
                          listenWhen: (previous, current) =>
                              current is AuthGoogleDone ||
                              current is AuthGoogleError,
                          listener: (context, state) {
                            if (state is AuthGoogleDone) {
                              Navigator.of(context).pushNamed(AppRoutes.home);
                            }
                            if (state is AuthGoogleError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is AuthGoogleLoading ||
                              current is AuthGoogleDone ||
                              current is AuthGoogleError,
                          builder: (context, state) {
                            if (state is AuthGoogleLoading) {
                              return SocialMediaButton(isLoading: true);
                            }
                            return SocialMediaButton(
                              text: "Sign up with Google",
                              imgUrl:
                                  "https://toppng.com/uploads/preview/google-logo-transparent-png-11659866441wanynck5pd.png",
                              onTap: () {
                                cubit.authenticateWithGoogle();
                              },
                            );
                          },
                        ),
                        SizedBox(height: 16),
                        BlocConsumer<AuthCubit, AuthState>(
                          bloc: cubit,
                          listenWhen: (previous, current) =>
                              current is AuthFacebookDone ||
                              current is AuthFacebookError,
                          listener: (context, state) {
                            if (state is AuthFacebookDone) {
                              Navigator.of(context).pushNamed(AppRoutes.home);
                            } else if (state is AuthFacebookError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            }
                          },
                          buildWhen: (previous, current) =>
                              current is AuthFacebookLoading ||
                              current is AuthFacebookError ||
                              current is AuthFacebookDone,
                          builder: (context, state) {
                            if (state is AuthFacebookLoading) {
                              return SocialMediaButton(isLoading: true);
                            }
                            return SocialMediaButton(
                              text: "Sign up with Facebook",
                              imgUrl:
                                  "https://clipartcraft.com/images/facebook-logo-circle-2.png",
                              onTap: () async {
                                await cubit.authenticateWithFacebook();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:e_commerce/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServicesImpl();

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await authServices.login(email, password);
      if (result) {
        emit(AuthDone());
      } else {
        emit(AuthError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await authServices.register(email, password);
      if (result) {
        emit(AuthDone());
      } else {
        emit(AuthError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void checkAuth() {
    final user = authServices.currentUser();
    if (user != null) {
      emit(AuthDone());
    }
  }

  Future<void> logout() async {
    emit(AuthLoggingout());
    try {
      await Future.delayed(const Duration(seconds: 1));
      await authServices.logout();
      emit(AuthLoggedout());
    } catch (e) {
      emit(AuthLogoutError(e.toString()));
    }
  }

  Future<void> authenticateWithGoogle() async {
    emit(AuthGoogleLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await authServices.authenticateWithGoogle();
      if (result) {
        emit(AuthGoogleDone());
      } else {
        emit(AuthGoogleError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthGoogleError(e.toString()));
    }
  }

  Future<void> authenticateWithFacebook() async {
    emit(AuthFacebookLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await authServices.authenticateWithFacebook();
      if (result) {
        emit(AuthFacebookDone());
      } else {
        emit(AuthFacebookError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthFacebookError(e.toString()));
    }
  }
}

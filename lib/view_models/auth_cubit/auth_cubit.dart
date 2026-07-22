import 'package:e_commerce/models/user_data.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServicesImpl();
  final firestoreServices = FirestoreServices.instance;

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

  Future<void> register(String email, String password, String username) async {
    emit(AuthLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final result = await authServices.register(email, password);
      if (result) {
        await _saveUserData(email, username);
        emit(AuthDone());
      } else {
        emit(AuthError('Invalid email or password'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _saveUserData(String email, String username) async {
    final currentUser = authServices.currentUser();
    final userData = UserData(
      id: currentUser!.uid,
      name: username,
      email: email,
      createdAt: DateTime.now().toIso8601String(),
    );
    await firestoreServices.setData(
      path: ApiPaths.user(currentUser.uid),
      data: userData.toMap(),
    );
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

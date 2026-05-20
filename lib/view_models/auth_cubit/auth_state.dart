part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthDone extends AuthState {
  AuthDone();
}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

final class AuthLoggedout extends AuthState {
  AuthLoggedout();
}

final class AuthLoggingout extends AuthState {
  AuthLoggingout();
}

final class AuthLogoutError extends AuthState {
  final String message;
  AuthLogoutError(this.message);
}

final class AuthGoogleLoading extends AuthState {}

final class AuthGoogleDone extends AuthState {
  AuthGoogleDone();
}

final class AuthGoogleError extends AuthState {
  final String message;
  AuthGoogleError(this.message);
}

final class AuthFacebookLoading extends AuthState {}

final class AuthFacebookDone extends AuthState {
  AuthFacebookDone();
}

final class AuthFacebookError extends AuthState {
  final String message;
  AuthFacebookError(this.message);
}

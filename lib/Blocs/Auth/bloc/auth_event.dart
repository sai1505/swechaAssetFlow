part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignUpRequested extends AuthEvent {
  late final String email, password;
  SignUpRequested({
    required this.email,
    required this.password,
  });
}

final class SignInRequested extends AuthEvent {
  late final String email, password;
  SignInRequested({
    required this.email,
    required this.password,
  });
}

class LogoutRequested extends AuthEvent {}

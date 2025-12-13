import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:swecha_asset_flow/Repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final res = await authRepository.signUp(
          event.email,
          event.password,
        );

        if (res.user != null) {
          emit(AuthSuccess());
        } else {
          emit(AuthError('Signup failed'));
        }
      } catch (e) {
        debugPrint('AUTH ERROR: $e');
        emit(AuthError(e.toString()));
      }
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final res = await authRepository.signIn(
          event.email,
          event.password,
        );

        if (res.user != null) {
          emit(AuthSuccess());
        } else {
          emit(AuthError('Login failed'));
        }
      } catch (e) {
        debugPrint('AUTH ERROR: $e');
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signOut();
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}

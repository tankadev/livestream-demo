import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hitalive/enums/enums.dart';
import 'package:hitalive/repositories/repositories.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(const AuthState.unknown()) {
    on<AuthStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthLogoutRequested>(_onAuthenticationLogoutRequested);
    authStatusSubscription = authRepository.status.listen(
          (status) => add(AuthStatusChanged(status)),
    );
  }

  final AuthRepository authRepository;
  late StreamSubscription<EAuthStatus> authStatusSubscription;

  @override
  Future<void> close() {
    authStatusSubscription.cancel();
    authRepository.dispose();
    return super.close();
  }

  void _onAuthenticationStatusChanged(
      AuthStatusChanged event,
      Emitter<AuthState> emit,
      ) async {
    switch (event.status) {

      case EAuthStatus.unknown:
        await Future.delayed(const Duration(milliseconds: 2000));
        return emit(const AuthState.unauthenticated());

      case EAuthStatus.authenticated:
        return emit(const AuthState.authenticated());

      case EAuthStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());

      default:
        return emit(const AuthState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
      AuthLogoutRequested event,
      Emitter<AuthState> emit,
      ) async {
    await authRepository.logOut();
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:hitalive/repositories/repositories.dart';
import 'package:hitalive/enums/enums.dart';
import 'package:hitalive/dto/dto.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.authRepository}) : super(LoginState()) {
    on<LoginSubmitted>(_onSubmitted);
    on<ChangeObscurePasswordLogin>(_onChangeObscurePassword);
  }

  final AuthRepository authRepository;

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.loginForm.valid) {
      emit(state.copyWith(status: EBlocStateStatus.inProgress));
      try {
        await authRepository.logIn(LoginDTO.fromJson(state.loginForm.value));
        emit(state.copyWith(status: EBlocStateStatus.success));
      } on DioError catch (e) {
        String errorCode = '';
        if (e.response != null &&
            e.response?.data != null &&
            e.response?.data['errorCode'] != null) {
          errorCode = e.response?.data['errorCode'];
        }
        emit(state.copyWith(
            status: EBlocStateStatus.failure, errorCode: errorCode));
      }
    } else {
      state.loginForm.markAllAsTouched();
    }
  }

  void _onChangeObscurePassword(
    ChangeObscurePasswordLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(obscurePassword: event.value));
  }
}

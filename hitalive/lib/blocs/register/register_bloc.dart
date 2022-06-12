import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:hitalive/enums/enums.dart';
import 'package:hitalive/utilities/utilities.dart';
import 'package:hitalive/repositories/repositories.dart';
import 'package:hitalive/dto/dto.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required this.authRepository}) : super(RegisterState()) {
    on<RegisterSubmitted>(_onSubmitted);
    on<ChangeObscurePassword>(_onChangeObscurePassword);
    on<ChangeObscureRePassword>(_onChangeObscureRePassword);
  }

  final AuthRepository authRepository;

  void _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.registerForm.valid) {
      emit(state.copyWith(status: EBlocStateStatus.inProgress));
      try {
        await authRepository
            .register(RegisterDTO.fromJson(state.registerForm.value));
        emit(state.copyWith(status: EBlocStateStatus.success));
      } on DioError catch (e) {
        print(e);
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
      state.registerForm.markAllAsTouched();
    }
  }

  void _onChangeObscurePassword(
    ChangeObscurePassword event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(obscurePassword: event.value));
  }

  void _onChangeObscureRePassword(
    ChangeObscureRePassword event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(obscureRePassword: event.value));
  }
}

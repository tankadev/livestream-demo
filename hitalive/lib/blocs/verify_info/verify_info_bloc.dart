import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:hitalive/enums/enums.dart';
import 'package:hitalive/repositories/repositories.dart';
import 'package:hitalive/dto/dto.dart';
import 'package:hitalive/utilities/utilities.dart';

part 'verify_info_event.dart';
part 'verify_info_state.dart';

class VerifyInfoBloc extends Bloc<VerifyInfoEvent, VerifyInfoState> {
  VerifyInfoBloc({required this.userRepository}) : super(VerifyInfoState()) {
    on<VerifyInfoSubmitted>(_onSubmitted);
    on<SelectedBirthday>(_onSelectedBirthday);
    on<SelectedImage>(_onSelectedImage);
  }

  final UserRepository userRepository;

  void _onSubmitted(
    VerifyInfoSubmitted event,
    Emitter<VerifyInfoState> emit,
  ) async {
    emit(state.copyWith(status: EBlocStateStatus.pure));
    if (state.verifyForm.valid) {
      if (state.image == null) {
        emit(state.copyWith(
            status: EBlocStateStatus.failure,
            errorCode: 'Vui lòng chọn hình xác thực'));
      } else {
        emit(state.copyWith(status: EBlocStateStatus.inProgress));
        try {
          await userRepository.addVerifyInformation(
              VerifyInfoDTO.fromJson(state.verifyForm.value, state.image));
          emit(state.copyWith(status: EBlocStateStatus.success));
        } catch (e) {
          emit(state.copyWith(
              status: EBlocStateStatus.failure,
              errorCode: 'Gửi thông tin xác thực không thành công'));
        }
      }
    } else {
      state.verifyForm.markAllAsTouched();
    }
  }

  void _onSelectedBirthday(
    SelectedBirthday event,
    Emitter<VerifyInfoState> emit,
  ) async {
    state.verifyForm.control('birthday').value =
        DateTimeUtil.formatDateWithString(
            format: 'dd/MM/yyyy', inputDate: event.day);
    emit(state.copyWith(selectedBirthday: event.day, status: EBlocStateStatus.pure));
  }

  void _onSelectedImage(
    SelectedImage event,
    Emitter<VerifyInfoState> emit,
  ) async {
    emit(state.copyWith(image: event.file, status: EBlocStateStatus.pure));
  }
}

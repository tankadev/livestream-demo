part of 'verify_info_bloc.dart';

class VerifyInfoState extends Equatable {
  VerifyInfoState(
      {this.status = EBlocStateStatus.pure,
      this.errorCode = '',
      this.image,
      this.selectedBirthday,
      FormGroup? form})
      : verifyForm = form ??
            FormGroup({
              'firstName':
                  FormControl<String>(validators: [Validators.required]),
              'lastName':
                  FormControl<String>(validators: [Validators.required]),
              'address': FormControl<String>(validators: [Validators.required]),
              'birthday':
                  FormControl<String>(validators: [Validators.required]),
            });

  final FormGroup verifyForm;
  final File? image;
  final EBlocStateStatus status;
  final String errorCode;
  final DateTime? selectedBirthday;

  VerifyInfoState copyWith(
      {EBlocStateStatus? status,
      String? errorCode,
      File? image,
      DateTime? selectedBirthday}) {
    return VerifyInfoState(
      status: status ?? this.status,
      form: verifyForm,
      image: image ?? this.image,
      errorCode: errorCode ?? this.errorCode,
      selectedBirthday: selectedBirthday ?? this.selectedBirthday,
    );
  }

  @override
  List<Object?> get props =>
      [verifyForm, status, errorCode, image, selectedBirthday];
}

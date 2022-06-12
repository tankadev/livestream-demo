part of 'register_bloc.dart';

class RegisterState extends Equatable {
  RegisterState(
      {this.status = EBlocStateStatus.pure,
      this.obscurePassword = true,
      this.obscureRePassword = true,
      this.errorCode = '',
      FormGroup? form})
      : registerForm = form ??
            FormGroup({
              'email': FormControl<String>(
                  validators: [Validators.required, Validators.email]),
              'password':
                  FormControl<String>(validators: [Validators.required]),
              'rePassword': FormControl<String>(),
            }, validators: [
              FormUtilities.mustMatch('password', 'rePassword')
            ]);

  final FormGroup registerForm;
  final EBlocStateStatus status;
  final bool obscurePassword;
  final bool obscureRePassword;
  final String errorCode;

  RegisterState copyWith({
    EBlocStateStatus? status,
    bool? obscurePassword,
    bool? obscureRePassword,
    String? errorCode,
  }) {
    return RegisterState(
      status: status ?? this.status,
      form: registerForm,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureRePassword: obscureRePassword ?? this.obscureRePassword,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object?> get props =>
      [registerForm, status, obscurePassword, obscureRePassword, errorCode];
}

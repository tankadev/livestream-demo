part of 'login_bloc.dart';

class LoginState extends Equatable {
  LoginState({
    this.status = EBlocStateStatus.pure,
    this.obscurePassword = true,
    FormGroup? form,
    this.errorCode = '',
  }) : loginForm = form ??
            FormGroup(
              {
                'email': FormControl<String>(
                    validators: [Validators.required, Validators.email]),
                'password':
                    FormControl<String>(validators: [Validators.required]),
              },
            );

  final FormGroup loginForm;
  final EBlocStateStatus status;
  final bool obscurePassword;
  final String errorCode;

  LoginState copyWith({
    EBlocStateStatus? status,
    bool? obscurePassword,
    String? errorCode,
  }) {
    return LoginState(
      status: status ?? this.status,
      form: loginForm,
      obscurePassword:
          (obscurePassword != null) ? obscurePassword : this.obscurePassword,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  List<Object?> get props => [loginForm, status, obscurePassword, errorCode];
}

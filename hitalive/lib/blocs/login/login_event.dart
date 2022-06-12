part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class ChangeObscurePasswordLogin extends LoginEvent {
  const ChangeObscurePasswordLogin({required this.value});

  final bool value;

  @override
  List<Object> get props => [value];
}

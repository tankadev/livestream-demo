part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}

class ChangeObscurePassword extends RegisterEvent {
  const ChangeObscurePassword({required this.value});

  final bool value;

  @override
  List<Object> get props => [value];
}

class ChangeObscureRePassword extends RegisterEvent {
  const ChangeObscureRePassword({required this.value});

  final bool value;

  @override
  List<Object> get props => [value];
}
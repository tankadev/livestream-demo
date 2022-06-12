part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({this.status = EAuthStatus.unknown});

  const AuthState.unknown() : this._();

  const AuthState.authenticated() : this._(status: EAuthStatus.authenticated);

  const AuthState.unauthenticated()
      : this._(status: EAuthStatus.unauthenticated);

  final EAuthStatus status;

  @override
  List<Object?> get props => [status];
}

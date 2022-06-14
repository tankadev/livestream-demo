part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({this.status = EBlocStateStatus.pure, this.user});

  final EBlocStateStatus status;
  final UserRO? user;

  AccountState copyWith({
    EBlocStateStatus? status,
    UserRO? user,
  }) {
    return AccountState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [status];
}

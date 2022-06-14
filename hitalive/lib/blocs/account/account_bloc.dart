import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hitalive/enums/enums.dart';
import 'package:hitalive/repositories/repositories.dart';
import 'package:hitalive/ro/ro.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({required this.userRepository}) : super(const AccountState()) {
    on<FetchUser>(_onFetchUser);
  }

  final UserRepository userRepository;

  void _onFetchUser(
    FetchUser event,
    Emitter<AccountState> emit,
  ) async {
    emit(state.copyWith(status: EBlocStateStatus.inProgress));
    try {
      final user = await userRepository.getUserInfo();
      emit(state.copyWith(status: EBlocStateStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: EBlocStateStatus.failure));
    }
  }
}

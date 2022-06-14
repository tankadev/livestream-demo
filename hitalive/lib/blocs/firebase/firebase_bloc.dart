import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:hitalive/repositories/repositories.dart';

part 'firebase_event.dart';
part 'firebase_state.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  FirebaseBloc({required this.userRepository}) : super(const FirebaseState()) {
    on<UpdateTokenFirebase>(_onUpdateTokenFirebase);
    on<SaveTokenFirebase>(_onSaveTokenFirebase);
  }

  final UserRepository userRepository;

  void _onUpdateTokenFirebase(
    UpdateTokenFirebase event,
    Emitter<FirebaseState> emit,
  ) async {
    emit(state.copyWith(token: event.token));
  }

  void _onSaveTokenFirebase(
    SaveTokenFirebase event,
    Emitter<FirebaseState> emit,
  ) async {
    try {
      print(state.token);
      if (state.token.isNotEmpty) {
        await userRepository.updatePushToken(state.token);
      }
    } catch (e) {
      //
    }
  }
}

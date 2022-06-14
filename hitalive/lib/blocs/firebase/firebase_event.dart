part of 'firebase_bloc.dart';

abstract class FirebaseEvent extends Equatable {
  const FirebaseEvent();

  @override
  List<Object> get props => [];
}

class UpdateTokenFirebase extends FirebaseEvent {
  const UpdateTokenFirebase({required this.token});

  final String token;
  @override
  List<Object> get props => [token];
}

class SaveTokenFirebase extends FirebaseEvent {
  const SaveTokenFirebase();

  @override
  List<Object> get props => [];
}

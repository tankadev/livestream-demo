part of 'firebase_bloc.dart';

class FirebaseState extends Equatable {
  const FirebaseState({this.token = ''});

  final String token;

  FirebaseState copyWith({
    String? token,
  }) {
    return FirebaseState(
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [token];
}

part of 'verify_info_bloc.dart';

abstract class VerifyInfoEvent extends Equatable {
  const VerifyInfoEvent();

  @override
  List<Object> get props => [];
}

class VerifyInfoSubmitted extends VerifyInfoEvent {
  const VerifyInfoSubmitted();
}

class SelectedBirthday extends VerifyInfoEvent {
  const SelectedBirthday({required this.day});

  final DateTime day;

  @override
  List<Object> get props => [day];
}

class SelectedImage extends VerifyInfoEvent {
  const SelectedImage({required this.file});

  final File file;

  @override
  List<Object> get props => [file];
}

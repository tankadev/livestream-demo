part of 'privates_nav_bloc.dart';

abstract class PrivatesNavEvent extends Equatable {
  const PrivatesNavEvent();

  @override
  List<Object> get props => [];
}

class OnChangeHomeBottomBar extends PrivatesNavEvent {
  const OnChangeHomeBottomBar({required this.bottomBar});

  final int bottomBar;

  @override
  List<Object> get props => [bottomBar];
}

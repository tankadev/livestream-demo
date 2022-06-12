part of 'privates_nav_bloc.dart';

class PrivatesNavState extends Equatable {
  const PrivatesNavState(
      {this.currentBottomBar = 0, this.notificationBadge = 0});

  final int currentBottomBar;
  final int notificationBadge;

  PrivatesNavState copyWith({
    int? currentBottomBar,
    int? notificationBadge,
  }) {
    return PrivatesNavState(
      currentBottomBar: currentBottomBar ?? this.currentBottomBar,
      notificationBadge: notificationBadge ?? this.notificationBadge,
    );
  }

  @override
  List<Object?> get props => [currentBottomBar];
}

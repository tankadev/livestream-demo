import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'privates_nav_event.dart';
part 'privates_nav_state.dart';

class PrivatesNavBloc extends Bloc<PrivatesNavEvent, PrivatesNavState> {
  PrivatesNavBloc() : super(const PrivatesNavState()) {
    on<OnChangeHomeBottomBar>(_onChangeBottomBar);
  }

  void _onChangeBottomBar(
    OnChangeHomeBottomBar event,
    Emitter<PrivatesNavState> emit,
  ) async {
    emit(state.copyWith(currentBottomBar: event.bottomBar));
  }
}

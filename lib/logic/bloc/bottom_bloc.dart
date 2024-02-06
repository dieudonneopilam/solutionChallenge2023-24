import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_event.dart';
part 'bottom_state.dart';

class BottomBloc extends Bloc<BottomEvent, BottomState> {
  BottomBloc() : super(const BottomInitial(index: 0)) {
    on<ChangeIndex>((event, emit) {
      emit((state as BottomInitial).copywith(index: event.index));
    });
  }
}

part of 'bottom_bloc.dart';

sealed class BottomEvent extends Equatable {
  const BottomEvent();

  @override
  List<Object> get props => [];
}

class ChangeIndex extends BottomEvent {
  final int index;
  const ChangeIndex({required this.index});
}

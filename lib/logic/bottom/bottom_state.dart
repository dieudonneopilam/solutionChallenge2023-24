part of 'bottom_bloc.dart';

sealed class BottomState extends Equatable {
  const BottomState();

  @override
  List<Object> get props => [];
}

final class BottomInitial extends BottomState {
  final int index;
  const BottomInitial({required this.index});
  BottomInitial copywith({int? index}) =>
      BottomInitial(index: index ?? this.index);
  @override
  List<Object> get props => [index];
}

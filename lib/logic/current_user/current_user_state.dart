part of 'current_user_bloc.dart';

sealed class CurrentUserState extends Equatable {
  const CurrentUserState();

  @override
  List<Object> get props => [];
}

final class CurrentUserInitial extends CurrentUserState {
  final UserModel? userModel;
  const CurrentUserInitial({this.userModel});
  @override
  List<Object> get props => [userModel!];
}

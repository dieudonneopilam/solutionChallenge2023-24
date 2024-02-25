part of 'state_auth_bloc.dart';

sealed class StateAuthState extends Equatable {
  const StateAuthState();

  @override
  List<Object> get props => [];
}

final class IsLogin extends StateAuthState {
  final User user;
  const IsLogin({required this.user});

  @override
  List<Object> get props => [user];
}

final class IsLogut extends StateAuthState {}

final class IsNone extends StateAuthState {}

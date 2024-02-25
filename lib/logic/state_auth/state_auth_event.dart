part of 'state_auth_bloc.dart';

sealed class StateAuthEvent extends Equatable {
  const StateAuthEvent();

  @override
  List<Object> get props => [];
}

class SignIn extends StateAuthEvent {
  final User user;
  const SignIn({required this.user});
}
class SignOut extends StateAuthEvent {}

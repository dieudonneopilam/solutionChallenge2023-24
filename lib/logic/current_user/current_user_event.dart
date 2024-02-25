part of 'current_user_bloc.dart';

sealed class CurrentUserEvent extends Equatable {
  const CurrentUserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends CurrentUserEvent {
  final User user;
  const LoadUser({required this.user});
}
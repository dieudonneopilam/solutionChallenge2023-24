part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {
  final EtatRequest etatRequest;
  const SignInInitial({this.etatRequest = EtatRequest.none});
  @override
List<Object> get props => [etatRequest];
}

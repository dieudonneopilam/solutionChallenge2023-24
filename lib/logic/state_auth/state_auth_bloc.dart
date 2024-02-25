import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'state_auth_event.dart';
part 'state_auth_state.dart';

class StateAuthBloc extends Bloc<StateAuthEvent, StateAuthState> {
  late StreamSubscription streamSubscription;
  StateAuthBloc() : super(IsNone()) {
    on<SignIn>((event, emit) => emit(IsLogin(user: event.user)));
    on<SignOut>((event, emit) => emit(IsLogut()));
    streamSubscription =
        FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user == null) {
        add(SignOut());
      } else {
        add(SignIn(user: user));
      }
    });
  }
  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

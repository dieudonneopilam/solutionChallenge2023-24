import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solutionchallenge2024/models/user.dart';
import 'package:solutionchallenge2024/services/firestore.dart';

part 'current_user_event.dart';
part 'current_user_state.dart';

class CurrentUserBloc extends Bloc<CurrentUserEvent, CurrentUserState> {
  late StreamSubscription streamSubscription;
  CurrentUserBloc() : super(const CurrentUserInitial()) {
    on<LoadUser>((event, emit) async {
      try {
        UserModel? userModel =
            await FirestoreService().getUserByUid(event.user.uid);
        emit(CurrentUserInitial(userModel: userModel));
      } catch (e) {
        e.toString();
      }
    });
    streamSubscription =
        FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user == null) {
        //add(SignOut());
      } else {
        add(LoadUser(user: user));
      }
    });
  }
  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

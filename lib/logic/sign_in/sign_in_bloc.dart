import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solutionchallenge2024/models/user.dart';
import 'package:solutionchallenge2024/services/fireabse_auth.dart';
import 'package:solutionchallenge2024/services/firestore.dart';
import 'package:solutionchallenge2024/utils/enum.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirestoreService firestoreService = FirestoreService();
  final FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  SignInBloc() : super(const SignInInitial()) {
    on<SignInAction>((event, emit) async {
      try {
        emit(const SignInInitial(etatRequest: EtatRequest.loading));
        UserCredential? userCredential =
            await firebaseAuthService.loginUserGoogleAccount();
        if (userCredential == null) {
          emit(const SignInInitial(etatRequest: EtatRequest.error));
          emit(const SignInInitial(etatRequest: EtatRequest.none));
          return;
        }
        if (!await firestoreService.verifieUser(userCredential.user!)) {
          await firestoreService
              .createUser(UserModel.fromCredential(userCredential.user!));
        }
        emit(const SignInInitial(etatRequest: EtatRequest.loaded));
        emit(const SignInInitial(etatRequest: EtatRequest.none));
      } catch (e) {
        emit(const SignInInitial(etatRequest: EtatRequest.error));
        emit(const SignInInitial(etatRequest: EtatRequest.none));
      }
    });
  }
}

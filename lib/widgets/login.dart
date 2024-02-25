import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:solutionchallenge2024/logic/sign_in/sign_in_bloc.dart';
import 'package:solutionchallenge2024/utils/enum.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        (state as SignInInitial);
        return state.etatRequest == EtatRequest.loading
            ? SizedBox(
                height: MediaQuery.sizeOf(context).height - 100,
                child: Center(
                  child: Lottie.asset(
                    'assets/animation/laoding1.json',
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : SizedBox(
                height: MediaQuery.sizeOf(context).height - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animation/google.json',
                      height: 200,
                      width: 230,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: TextSmall(
                        'Connectez-vous pour contribuer a devoiler les endroits qui peuvent nuire a votre sante',
                        color: Colors.grey,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: () =>
                          context.read<SignInBloc>().add(SignInAction()),
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blue),
                        child: const TextSmall('Sign in with account google',
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solutionchallenge2024/logic/posts/post_bloc.dart';
import 'package:solutionchallenge2024/logic/state_auth/state_auth_bloc.dart';
import 'package:solutionchallenge2024/utils/enum.dart';
import 'package:solutionchallenge2024/widgets/box.cnt.post.dart';
import 'package:solutionchallenge2024/widgets/not_found.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        BlocBuilder<StateAuthBloc, StateAuthState>(
          builder: (context, state) {
            return SliverAppBar(
              floating: true,
              backgroundColor: Colors.red,
              centerTitle: false,
              title: const TextLarge('AlertHub', size: 25, color: Colors.white),
              actions: [
                (state is IsLogin)
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage((state).user.photoURL!))
                    : const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/img/default.png')),
                width20()
              ],
            );
          },
        ),
        const SliverPadding(padding: EdgeInsets.all(10)),
        BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            (state as PostInitial);
            return state.etatRequestAllPost == EtatField.none ||
                    state.etatRequestAllPost == EtatRequest.loading
                ? const SliverToBoxAdapter(child: LoadingWidget())
                : state.allPosts.isEmpty
                    ? const SliverToBoxAdapter(
                        child: NotFoundWidget(),
                      )
                    : SliverList.builder(
                        itemCount: state.allPosts.length,
                        itemBuilder: (context, index) => BoxContentPost(
                          postModel: state.allPosts[index],
                        ),
                      );
          },
        ),
      ],
    );
  }
}

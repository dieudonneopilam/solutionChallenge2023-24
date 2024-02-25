import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solutionchallenge2024/logic/posts/post_bloc.dart';
import 'package:solutionchallenge2024/logic/sign_in/sign_in_bloc.dart';
import 'package:solutionchallenge2024/logic/state_auth/state_auth_bloc.dart';
import 'package:solutionchallenge2024/services/fireabse_auth.dart';
import 'package:solutionchallenge2024/widgets/box.cnt.post.dart';
import 'package:solutionchallenge2024/widgets/login.dart';
import 'package:solutionchallenge2024/widgets/not_found.dart';
import 'package:solutionchallenge2024/widgets/sizebox.dart';
import 'package:solutionchallenge2024/widgets/text.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: CustomScrollView(slivers: [
        BlocBuilder<StateAuthBloc, StateAuthState>(
          builder: (context, state) {
            return (state is! IsLogin)
                ? const SliverToBoxAdapter()
                : SliverAppBar(
                  backgroundColor: const Color.fromARGB(255, 255, 187, 183),
                    toolbarHeight: 130,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      collapseMode: CollapseMode.pin,
                      titlePadding: const EdgeInsets.all(10),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          height25(),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage:
                                      NetworkImage((state).user.photoURL!),
                                ),
                                GestureDetector(
                                  onTap: () => FirebaseAuthService().logout(),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white),
                                    child: const TextSmall('Sign Out',
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                          height10(),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextMedium((state).user.displayName!),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 20),
                            child: TextSmall((state).user.email!),
                          ),
                        ],
                      ),
                    ),
                    bottom: TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                      indicatorColor: Colors.blue,
                      controller: tabController,
                      tabs: const [
                        TextMedium('Post', size: 16),
                        TextMedium('comments', size: 16),
                        TextMedium(
                          'Likes',
                          size: 16,
                        ),
                        TextMedium('views', size: 16)
                      ],
                    ),
                  );
          },
        ),
        BlocBuilder<StateAuthBloc, StateAuthState>(
          builder: (context, state) {
            return SliverToBoxAdapter(
              child: state is! IsLogin
                  ? const LoginScreen()
                  : SizedBox(
                    height: MediaQuery.sizeOf(context).height - 200,
                    child: BlocBuilder<PostBloc, PostState>(
                      builder: (context, state) {
                        (state as PostInitial);
                        return TabBarView(
                          controller: tabController,
                          children: [
                            state.postOfCurrentUser.isEmpty
                                ? const NotFoundWidget()
                                : ListView(
                                    children: [
                                      ...state.postOfCurrentUser.map(
                                          (e) => BoxContentPost(
                                              postModel: e)),
                                      height(400),
                                    ],
                                  ),
                            state.postsCommentsByI.isEmpty
                                ? const NotFoundWidget()
                                : ListView.builder(
                                    itemCount:
                                        state.postsCommentsByI.length,
                                    itemBuilder: (context, index) =>
                                        BoxContentPost(
                                            postModel:
                                                state.postsCommentsByI[
                                                    index]),
                                  ),
                            state.postLikesByI.isEmpty
                                ? const NotFoundWidget()
                                : ListView.builder(
                                    itemCount:
                                        state.postLikesByI.length,
                                    itemBuilder: (context, index) =>
                                        BoxContentPost(
                                            postModel: state
                                                .postLikesByI[index]),
                                  ),
                            state.postsSharedByI.isEmpty
                                ? const NotFoundWidget()
                                : ListView.builder(
                                    itemCount:
                                        state.postsSharedByI.length,
                                    itemBuilder: (context, index) =>
                                        BoxContentPost(
                                            postModel: state
                                                .postsSharedByI[index]),
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
            );
          },
        ),
      ]),
    );
  }
}

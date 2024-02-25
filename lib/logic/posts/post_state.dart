part of 'post_bloc.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {
  final EtatRequest etatRequestAllPost;
  final EtatRequest etatRequestMine;
  final List<PostModel> postOfCurrentUser;
  final List<PostModel> allPosts;
  final List<PostModel> postLikesByI;
  final List<PostModel> postsCommentsByI;
  final List<PostModel> postsSharedByI;

  const PostInitial({
    this.postOfCurrentUser = const [],
    this.allPosts = const [],
    this.postLikesByI = const [],
    this.postsCommentsByI = const [],
    this.postsSharedByI = const [],
    this.etatRequestAllPost = EtatRequest.none,
    this.etatRequestMine = EtatRequest.none,
  });

  PostInitial copywith({
    EtatRequest? etatRequestAllPost,
    EtatRequest? etatRequestMine,
    List<PostModel>? postOfCurrentUser,
    List<PostModel>? allPosts,
    List<PostModel>? postLikesByI,
    List<PostModel>? postsCommentsByI,
    List<PostModel>? postsSharedByI,
  }) =>
      PostInitial(
          etatRequestAllPost: etatRequestAllPost ?? this.etatRequestAllPost,
          allPosts: allPosts ?? this.allPosts,
          etatRequestMine: etatRequestMine ?? this.etatRequestMine,
          postLikesByI: postLikesByI ?? this.postLikesByI,
          postOfCurrentUser: postOfCurrentUser ?? this.postOfCurrentUser,
          postsCommentsByI: postsCommentsByI ?? this.postsCommentsByI,
          postsSharedByI: postsSharedByI ?? this.postsSharedByI);

  @override
  List<Object> get props => [
        postLikesByI,
        postOfCurrentUser,
        postsCommentsByI,
        postsSharedByI,
        etatRequestAllPost,
        etatRequestMine,
        allPosts,
      ];
}

// ignore_for_file: empty_catches

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solutionchallenge2024/models/post.dart';
import 'package:solutionchallenge2024/services/firestore.dart';
import 'package:solutionchallenge2024/utils/enum.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final FirestoreService firestoreService = FirestoreService();
  late StreamSubscription streamSubscription;
  PostBloc() : super(const PostInitial()) {
    on<LoadData>((event, emit) async {
      try {
        emit((state as PostInitial)
            .copywith(etatRequestAllPost: EtatRequest.loading));
        var data = await firestoreService.getAllPosts();
        emit((state as PostInitial).copywith(
            etatRequestAllPost: EtatRequest.loaded,
            allPosts: data['allPosts'],
            postLikesByI: data['postLikesByI'],
            postOfCurrentUser: data['postOfCurrentUser'],
            postsCommentsByI: data['postsCommentsByI'],
            postsSharedByI: data['postsSharedByI']));
      } catch (e) {}
    });
    streamSubscription = firestoreService.streamPost().listen((event) {
      add(LoadData());
    });
  }
  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }
}

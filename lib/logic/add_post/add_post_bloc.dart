import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:solutionchallenge2024/models/post.dart';
import 'package:solutionchallenge2024/services/firestore.dart';
import 'package:solutionchallenge2024/services/storage.dart';
import 'package:solutionchallenge2024/utils/enum.dart';
import 'package:uuid/uuid.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(const AddPostInitial()) {
    on<SavePost>((event, emit) async {
      try {
        emit((state as AddPostInitial)
            .copywith(etatRequest: EtatRequest.loading));
        var doc = const Uuid().v1();
        List<String> listImages = await StorageService()
            .getListImage(event.listImages, 'Posts', doc, event.user['uid']);
        PostModel postModel = PostModel(
          doc: doc,
          content: event.content,
          listImages: listImages,
          coordonnees: event.coordonnees,
          usersLikes: [],
          usersComments: [],
          usersShared: [],
          usersViews: [],
          dateCreated: DateTime.now(),
          user: event.user,
        );
        await FirestoreService().createPost(postModel);
        emit((state as AddPostInitial)
            .copywith(etatRequest: EtatRequest.loaded));
      } catch (e) {
        emit(
            (state as AddPostInitial).copywith(etatRequest: EtatRequest.error));
      }
    });
  }
}

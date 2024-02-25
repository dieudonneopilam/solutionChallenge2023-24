part of 'add_post_bloc.dart';

sealed class AddPostEvent extends Equatable {
  const AddPostEvent();

  @override
  List<Object> get props => [];
}

class SavePost extends AddPostEvent {
  final String content;
  final List<Uint8List> listImages;
  final Map<String, dynamic> coordonnees;
  final Map<String, dynamic> user;
  const SavePost({
    required this.content,
    required this.listImages,
    required this.coordonnees,
    required this.user,
  });
}

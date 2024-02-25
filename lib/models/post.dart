import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String doc;
  final String content;
  final List listImages;
  final Map<String, dynamic> coordonnees;
  final List usersLikes;
  final List usersComments;
  final List usersShared;
  final List usersViews;
  final DateTime dateCreated;
  final Map<String, dynamic> user;

  PostModel({
    required this.doc,
    required this.content,
    required this.listImages,
    required this.coordonnees,
    required this.usersLikes,
    required this.usersComments,
    required this.usersShared,
    required this.dateCreated,
    required this.user,
    required this.usersViews,
  });

  Map<String, dynamic> toJson() {
    return {
      'doc': doc,
      'content': content,
      'listImages': listImages,
      'coordonnees': coordonnees,
      'usersComments': usersComments,
      'usersLikes': usersLikes,
      'usersShared': usersShared,
      'usersViews': usersViews,
      'dateCreated': dateCreated,
      'user': user,
    };
  }

  static PostModel fromData(Map<String, dynamic> data) {
    Timestamp dateCreated = data['dateCreated'];
    return PostModel(
      doc: data['doc'],
      content: data['content'],
      listImages: data['listImages'],
      coordonnees: data['coordonnees'],
      usersLikes: data['usersLikes'],
      usersComments: data['usersComments'],
      usersShared: data['usersShared'],
      dateCreated: dateCreated.toDate(),
      user: data['user'],
      usersViews: data['usersViews'],
    );
  }
}

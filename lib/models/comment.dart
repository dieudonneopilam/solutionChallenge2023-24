// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String doc;
  final DateTime dateComment;
  final String comment;
  final String user_uid;
  final Map<String, dynamic> user;

  CommentModel(
      {required this.doc,
      required this.dateComment,
      required this.comment,
      required this.user_uid,
      required this.user});

  Map<String, dynamic> toJson() => {
        'doc': doc,
        'user': user,
        'dateComment': dateComment,
        'comment': comment,
        'user_uid': user_uid,
      };
  static CommentModel fromData(Map<String, dynamic> data) {
    Timestamp dateComment = data['dateComment'];
    return CommentModel(
      doc: data['doc'],
      user: data['user'],
      dateComment: dateComment.toDate(),
      comment: data['comment'],
      user_uid: data['user_uid'],
    );
  }
}

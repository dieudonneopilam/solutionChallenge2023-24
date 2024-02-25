import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String doc;
  final String title;
  final String typeNotification;
  final Map<String, dynamic> user;
  final DateTime dateCreated;
  final List users;
  NotificationModel({
    required this.doc,
    required this.title,
    required this.user,
    required this.dateCreated,
    required this.users,
    required this.typeNotification,
  });
  Map<String, dynamic> toJson() => {
        'doc': doc,
        'title': title,
        'typeNotification': typeNotification,
        'user': user,
        'users' : users,
        'dateCreated': dateCreated
      };
  static NotificationModel fromData(Map<String, dynamic> data) {
    Timestamp dateCreated = data['dateCreated'];
    return NotificationModel(
      doc: data['doc'],
      title: data['title'],
      user: data['user'],
      dateCreated: dateCreated.toDate(),
      users: data['users'],
      typeNotification: data['typeNotification'],
    );
  }
}

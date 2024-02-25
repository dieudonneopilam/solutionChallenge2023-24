import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String uid;
  final String name;
  final String urlImage;
  final String email;

  UserModel({
    required this.uid,
    required this.name,
    required this.urlImage,
    required this.email,
  });
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'urlImage': urlImage,
      'email': email,
    };
  }

  static UserModel fromData(Map<String, dynamic> data) {
    return UserModel(
        uid: data['uid'],
        name: data['name'],
        urlImage: data['urlImage'],
        email: data['email'],);
  }

  static UserModel fromCredential(User credential) {
    return UserModel(
      uid: credential.uid,
      name: credential.displayName ?? '',
      urlImage: credential.photoURL ?? '',
      email: credential.email ?? '',
    );
  }

  static UserModel userNone() =>
      UserModel(uid: '', name: '', urlImage: '', email: '');
}

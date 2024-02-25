// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solutionchallenge2024/models/comment.dart';
import 'package:solutionchallenge2024/models/notification.dart';
import 'package:solutionchallenge2024/models/post.dart';
import 'package:solutionchallenge2024/models/user.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  createPost(PostModel postModel) async {
    var user = FirebaseAuth.instance.currentUser;
    await firestore
        .collection('posts')
        .doc(postModel.doc)
        .set(postModel.toJson());
    var notification = NotificationModel(
        doc: const Uuid().v1(),
        title: 'Nouveau post',
        user: {
          'uid': user!.uid,
          'name': user.displayName,
          'urlImg': user.photoURL
        },
        dateCreated: DateTime.now(),
        users: [],
        typeNotification: 'newPost');
    if (user.uid != postModel.user['uid']) {
      createNotification(notification);
    }
  }

  createNotification(NotificationModel notificationModel) async {
    await firestore
        .collection('notifications')
        .doc(notificationModel.doc)
        .set(notificationModel.toJson());
  }

  Future<Map<String, dynamic>> getAllPosts() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('posts').get();
    var user = FirebaseAuth.instance.currentUser;
    List<PostModel> postOfCurrentUser = [];
    List<PostModel> allPosts = [];
    List<PostModel> postLikesByI = [];
    List<PostModel> postsCommentsByI = [];
    List<PostModel> postsSharedByI = [];
    for (var element in querySnapshot.docs) {
      PostModel postModel = PostModel.fromData(element.data());
      allPosts.add(postModel);
      if (user != null) {
        if (postModel.user['uid'] == user.uid) {
          postOfCurrentUser.add(postModel);
        }
        if (postModel.usersLikes.contains(user.uid)) {
          postLikesByI.add(postModel);
        }
        if (postModel.usersComments.contains(user.uid)) {
          postsCommentsByI.add(postModel);
        }
        if (postModel.usersShared.contains(user.uid)) {
          postsSharedByI.add(postModel);
        }
      }
    }
    return {
      'postOfCurrentUser': postOfCurrentUser,
      'allPosts': allPosts,
      'postLikesByI': postLikesByI,
      'postsCommentsByI': postsCommentsByI,
      'postsSharedByI': postsSharedByI
    };
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    List<NotificationModel> data = [];
    var user = FirebaseAuth.instance.currentUser;
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firestore.collection('notifications').get();
    for (var element in querySnapshot.docs) {
      NotificationModel notificationModel =
          NotificationModel.fromData(element.data());
      if (notificationModel.users.contains(user!.uid)) {
        data.add(notificationModel);
      }
    }
    return data;
  }

  Future<List<CommentModel>> getAllCommentByPost(String doc) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('posts')
        .doc(doc)
        .collection('comments')
        .get();
    List<CommentModel> list = [];

    try {
      for (var comment in querySnapshot.docs) {
        CommentModel commentModel = CommentModel.fromData(comment.data());
        list.add(commentModel);
      }
    } catch (e) {}
    return list;
  }

  newView(PostModel postModel) async {
    var user = FirebaseAuth.instance.currentUser;
    await firestore.collection('posts').doc(postModel.doc).update({
      'usersViews': FieldValue.arrayUnion([user!.uid])
    });
  }

  createComment(PostModel postModel, CommentModel commentModel) async {
    await firestore
        .collection('posts')
        .doc(postModel.doc)
        .collection('comments')
        .doc(commentModel.doc)
        .set(commentModel.toJson());
    await firestore.collection('posts').doc(postModel.doc).update({
      'usersComments': FieldValue.arrayUnion([commentModel.user_uid])
    });
    var user = FirebaseAuth.instance.currentUser;
    var notification = NotificationModel(
      doc: const Uuid().v1(),
      title: 'a commenté votre post',
      user: {
        'uid': user!.uid,
        'name': user.displayName,
        'urlImg': user.photoURL
      },
      dateCreated: DateTime.now(),
      users: [postModel.user['uid']],
      typeNotification: 'comment',
    );
    if (postModel.user['uid'] != user.uid) {
      createNotification(notification);
    }
  }

  likePost(PostModel postModel) async {
    var user = FirebaseAuth.instance.currentUser;
    if (!postModel.usersLikes.contains(user!.uid)) {
      await firestore.collection('posts').doc(postModel.doc).update({
        'usersLikes': FieldValue.arrayUnion([user.uid])
      });
      var notification = NotificationModel(
          doc: const Uuid().v1(),
          title: 'a aimé votre post',
          user: {
            'uid': user.uid,
            'name': user.displayName,
            'urlImg': user.photoURL
          },
          dateCreated: DateTime.now(),
          users: [postModel.user['uid']],
          typeNotification: 'like');
      if (postModel.user['uid'] != user.uid) {
        createNotification(notification);
      }
    } else {
      await firestore.collection('posts').doc(postModel.doc).update({
        'usersLikes': FieldValue.arrayRemove([user.uid])
      });
    }
  }

  sharePost(PostModel postModel, UserModel userModel) async {
    await firestore.collection('posts').doc(postModel.doc).update({
      'usersShared': FieldValue.arrayUnion([userModel.uid])
    });
    var notification = NotificationModel(
        doc: const Uuid().v1(),
        title: 'a partagé votre post',
        user: postModel.user,
        dateCreated: DateTime.now(),
        users: [],
        typeNotification: 'share');
    createNotification(notification);
  }

  createUser(UserModel userModel) async {
    await firestore
        .collection('users')
        .doc(userModel.uid)
        .set(userModel.toJson());
  }

  Future<bool> verifieUser(User user) async {
    DocumentSnapshot<Map<String, dynamic>> quer =
        await firestore.collection('users').doc(user.uid).get();
    return quer.exists;
  }

  Future<UserModel> getUserByUid(String uid) async {
    var query = await firestore.collection('users').doc(uid).get();
    return UserModel.fromData(query.data()!);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>?> streamCurrentUser() async* {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      yield null;
    } else {
      yield* firestore.collection('users').doc(user.uid).snapshots();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamPost() async* {
    yield* firestore.collection('posts').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotifications() async* {
    yield* firestore.collection('posts').snapshots();
  }
}

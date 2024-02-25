import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  Future<String> uploadImageToStorage(
      String uid, String childName, Uint8List file, String doc) async {
    Reference reference = firebaseStorage.ref().child(childName).child(uid);
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot snap = await uploadTask;
    String download = await snap.ref.getDownloadURL();
    return download;
  }

  Future<List<String>> getListImage(List<Uint8List> listImage, String childName,
      String doc, String uid) async {
    List<String> list = [];
    for (var file in listImage) {
      var backUrl = await uploadImageToStorage(uid, childName, file, doc);
      list.add(backUrl);
    }
    return list;
  }
}

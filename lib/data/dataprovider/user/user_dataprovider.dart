import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_project/data/dataprovider/user/user_dataprovider_base.dart';
import 'package:my_project/data/model/user_model.dart';

class UserDataProvider extends UserDataProviderBase {
  static const String collectionName = "user";

  @override
  Future<Map<String, dynamic>> getUser(String uid) async {
    late Map<String, dynamic> result;
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .get()
        .then((value) => result = value.data()!);
    return result;
  }

  @override
  Future<void> updateUser(String uid, UserModel user) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .set(user.toJson());
  }

  @override
  Future<String?> uploadAvatarUser(String uid, File image) async {
    const storagePath = "images/avatars/data/user/0/com.aci.travoapp/cache";
    late String result;
    FirebaseStorage storage = FirebaseStorage.instance;
    final reference = storage
        .ref()
        .child("$storagePath/$uid/${DateTime.now().toIso8601String()}.jpg");
    final uploadTask = await reference.putFile(
        image,
        SettableMetadata(
          contentType: "image/jpeg",
        ));
    result = await reference.getDownloadURL();
    return result.toString();
  }
}

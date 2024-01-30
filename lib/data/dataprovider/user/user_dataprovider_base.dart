

import 'dart:io';

import 'package:my_project/data/model/user_model.dart';

abstract class UserDataProviderBase{
  Future<Map<String, dynamic>> getUser(String uid);
  Future<void> updateUser(String uid, UserModel user);
  Future<String?> uploadAvatarUser(String uid, File image);
}
import 'dart:io';

import 'package:my_project/data/model/user_model.dart';

abstract class UserRepositoryBase {
  Future<UserModel> getUser(String uid);
  Future<void> updateUser(String uid, UserModel user);
  Future<String?> uploadAvatarUser(String uid, File image);
}

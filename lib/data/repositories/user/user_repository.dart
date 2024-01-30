import 'dart:io';

import 'package:my_project/data/dataprovider/user/user_dataprovider.dart';
import 'package:my_project/data/model/user_model.dart';
import 'package:my_project/data/repositories/user/user_repository_base.dart';

class UserRepository extends UserRepositoryBase {
  final UserDataProvider userDataProvider;

  UserRepository({required this.userDataProvider});

  @override
  Future<UserModel> getUser(String uid) async {
    final response = await userDataProvider.getUser(uid);
    return UserModel.fromJson(response);
  }

  @override
  Future<String?> uploadAvatarUser(String uid, File image) async {
    final response = await userDataProvider.uploadAvatarUser(uid, image);
    return response;
  }

  @override
  Future<void> updateUser(String uid, UserModel user) async {
    await userDataProvider.updateUser(uid, user);
  }
}

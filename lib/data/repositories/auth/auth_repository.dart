import 'package:my_project/data/dataprovider/auth/auth_dataprovider.dart';

import 'auth_repository_base.dart';

class AuthRepository extends AuthRepositoryBase {
  final AuthDataProvider authDataProvider;

  AuthRepository({required this.authDataProvider});

  @override
  Future<void> signUpWithEmailAndPassword(
      String name,String country, String phone, String email, String password) async {
    await authDataProvider.signUpWithEmailAndPassword(name, country, phone, email, password);
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await authDataProvider.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async{
    await authDataProvider.sendPasswordResetEmail(email);
  }

  @override
  Future<void> signOut() async{
    await authDataProvider.signOut();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_project/data/dataprovider/auth/auth_dataprovider_base.dart';
import 'package:my_project/data/services/shared_service.dart';

class AuthDataProvider extends AuthDataProviderBase {
  static const String collectionName= "user";
  @override
  Future<void> signUpWithEmailAndPassword(
      String name, String country, String phone, String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    // await FirebaseAuth.instance.currentUser?.updateEmail(email);
    // await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
    //? Save Into FireStore
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(userCredential.user?.uid)
        .set({'email': email, "name": name, "phoneNumber": phone, "country": country});

    //? Save Into Local
    SharedService.setUserId(FirebaseAuth.instance.currentUser!.uid);
    SharedService.setUserEmail(email);

  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    //? Save Into Local
    SharedService.setUserId(FirebaseAuth.instance.currentUser!.uid);
    SharedService.setUserEmail(email);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();

    //? Clear From Local
    SharedService.clearAllKey();
  }
}

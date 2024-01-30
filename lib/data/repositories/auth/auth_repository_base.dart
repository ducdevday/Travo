abstract class AuthRepositoryBase{
  Future<void> signUpWithEmailAndPassword(String name,String country, String phone, String email, String password);
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
}
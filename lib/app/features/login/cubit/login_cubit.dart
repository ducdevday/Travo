part of login;

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginCubit({required this.authRepository})
      : super(LoginInitial());

  void checkValidField(
    String email,
    String password,
  ) {
    if (ValidateFieldUtil.validateEmail(email) &&
        ValidateFieldUtil.validatePassword(password)) {
      emit(LoginReady());
    } else {
      emit(LoginInitial());
    }
  }

  void doLogin(String email, String password) async {
    emit(LoginInProgress());
    try {
      await authRepository.signInWithEmailAndPassword(email, password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        emit(const LoginFailure(message: "User Not Found"));
      } else if (e.code == "wrong-password") {
        emit(const LoginFailure(message: "Wrong Password"));
      }
      else if(e.code == "user-disabled"){
        emit(const LoginFailure(message: "User Disabled"));
      }
      else if (e.code == "invalid-credential") {
        emit(const LoginFailure(message: "Wrong Email Or Password"));
      } else {
        emit(const LoginFailure());
      }
    } catch (e) {
      print(e);
      emit(const LoginFailure());
    }
  }
}

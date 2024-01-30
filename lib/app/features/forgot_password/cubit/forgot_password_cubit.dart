part of forgot_password;

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository authRepository;
  ForgotPasswordCubit({required this.authRepository}) : super(ForgotPasswordInitial());

  void checkValidField(
      String email,
      ) {
    if (ValidateFieldUtil.validateEmail(email)) {
      emit(ForgotPasswordReady());
    } else {
      emit(ForgotPasswordInitial());
    }
  }

  void sendLinkResetPassword(String email) async {
    emit(ForgotPasswordInProgress());
    try {
      await authRepository.sendPasswordResetEmail(email);
      emit(ForgotPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'user-not-found') {
        emit(const ForgotPasswordFailure(message: "User Not Found"));
      } else {
        emit(const ForgotPasswordFailure());
      }
    } catch (e) {
      print(e);
      emit(const ForgotPasswordFailure());
    }
  }
}

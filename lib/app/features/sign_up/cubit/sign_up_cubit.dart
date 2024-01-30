part of sign_up;

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;

  SignUpCubit({required this.authRepository})
      : super(SignUpInitial());

  void checkValidField(
    String name,
    String email,
    String password,
    String country,
    String phone,
    CountryCode code,
  ) {
    if (ValidateFieldUtil.validateName(name) &&
        ValidateFieldUtil.validateEmail(email) &&
        ValidateFieldUtil.validatePassword(password) &&
        ValidateFieldUtil.validateCountry(country) &&
        ValidateFieldUtil.validatePhone(code, phone)) {
      emit(SignUpReady());
    }
    else{
      emit(SignUpInitial());
    }
  }

  Future<void> doSignUp(String name, String country, String phone, String email,
      String password) async {
    emit(SignUpInProgress());
    try {
      await authRepository.signUpWithEmailAndPassword(
          name, country, phone, email, password);
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(SignUpFailure(message: "Email Already In Use"));
      } else {
        emit(SignUpFailure());
      }
    } catch (e) {
      emit(SignUpFailure());
    }
  }
}

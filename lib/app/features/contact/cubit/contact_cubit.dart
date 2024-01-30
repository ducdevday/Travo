part of contact;

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());

  void checkValidField(
    String name,
    String email,
    String phone,
    CountryCode code,
  ) {
    if (ValidateFieldUtil.validateName(name) &&
        ValidateFieldUtil.validateEmail(email) &&
        ValidateFieldUtil.validatePhone(code, phone)) {
      emit(ContactReady());
    } else {
      emit(ContactInitial());
    }
  }
}

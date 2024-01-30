part of add_card;

class AddCardCubit extends Cubit<AddCardState> {
  AddCardCubit() : super(AddCardInitial());

  void checkValidField(String name, String country, String cardNumber,
      String expDate, String cvv) {
    if (ValidateFieldUtil.validateName(name) &&
        ValidateFieldUtil.validateCountry(country) &&
        ValidateFieldUtil.validateCardNum(cardNumber) &&
        ValidateFieldUtil.validateDate(expDate) &&
        ValidateFieldUtil.validateCVV(cvv)) {
      emit(AddCardReady());
    } else {
      emit(AddCardInitial());
    }
  }

  void addCard(){
    emit(AddCardSuccess());
  }
}

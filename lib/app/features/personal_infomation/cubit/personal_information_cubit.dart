part of personal_information;

class PersonalInformationCubit extends Cubit<PersonalInformationState> {
  final UserRepository userRepository;

  PersonalInformationCubit({required this.userRepository})
      : super(PersonalInformationInitial());

  void checkValidField(
    String name,
    String email,
    String country,
    String phone,
    CountryCode code,
  ) {
    if (ValidateFieldUtil.validateName(name) &&
        ValidateFieldUtil.validateEmail(email) &&
        ValidateFieldUtil.validateCountry(country) &&
        ValidateFieldUtil.validatePhone(code, phone)) {
      emit(PersonalInformationReady());
    } else {
      emit(PersonalInformationInitial());
    }
  }

  Future<String?> uploadAvatarUserFromGallery() async {
    emit(PersonalInformationLoadInProcess());
    try {
      final resultImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (resultImage != null) {
        final avatar = await userRepository.uploadAvatarUser(
            SharedService.getUserId()!, File(resultImage.path));
        emit(PersonalInformationUploadImageSuccess());
        return avatar;
      }
      emit(PersonalInformationLoadFailure(message: "Upload Image Fail"));
    } catch (e) {
      emit(PersonalInformationLoadFailure());
      print(e);
    }
    return null;
  }

  Future<String?> uploadAvatarUserFromCamera() async {
    emit(PersonalInformationLoadInProcess());
    try {
      final resultImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (resultImage != null) {
        final avatar = await userRepository.uploadAvatarUser(
            SharedService.getUserId()!, File(resultImage.path));
        emit(PersonalInformationUploadImageSuccess());
        return avatar;
      }
      emit(PersonalInformationLoadFailure(message: "Upload Image Fail"));
    } catch (e) {
      emit(PersonalInformationLoadFailure());
      print(e);
    }
    return null;
  }

  Future<void> updateUser(String uid, UserModel user) async {
    emit(PersonalInformationLoadInProcess());
    try {
      await userRepository.updateUser(uid, user);
      emit(PersonalInformationUpdateSuccess());
    } catch (e) {
      emit(PersonalInformationLoadFailure());
    }
  }
}

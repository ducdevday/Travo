part of personal_information;

abstract class PersonalInformationState extends Equatable {
  const PersonalInformationState();
}

class PersonalInformationInitial extends PersonalInformationState {
  @override
  List<Object> get props => [];
}

class PersonalInformationReady extends PersonalInformationState {
  @override
  List<Object> get props => [];
}

class PersonalInformationLoadInProcess extends PersonalInformationState {
  @override
  List<Object> get props => [];
}

class PersonalInformationUploadImageSuccess extends PersonalInformationState {
  @override
  List<Object> get props => [];
}

class PersonalInformationUpdateSuccess extends PersonalInformationState {
  @override
  List<Object> get props => [];
}

class PersonalInformationLoadFailure extends PersonalInformationState {
  final String? message;

  const PersonalInformationLoadFailure({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

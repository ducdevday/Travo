part of sign_up;

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {
}

class SignUpReady extends SignUpState {
}

class SignUpInProgress extends SignUpState {
}

class SignUpSuccess extends SignUpState {
}

class SignUpFailure extends SignUpState {
  final String? message;

  const SignUpFailure({
    this.message,
  });
}
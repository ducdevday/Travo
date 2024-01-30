part of forgot_password;

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {
}

class ForgotPasswordReady extends ForgotPasswordState{

}

class  ForgotPasswordInProgress extends ForgotPasswordState{

}

class  ForgotPasswordSuccess extends ForgotPasswordState{

}

class ForgotPasswordFailure extends ForgotPasswordState{
  final String? message;

  const ForgotPasswordFailure({
    this.message,
  });
}
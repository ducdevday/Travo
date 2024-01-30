part of login;

abstract class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {

}

class LoginReady extends LoginState{

}

class LoginInProgress extends LoginState{

}

class LoginSuccess extends LoginState{

}

class LoginFailure extends LoginState{
  final String? message;

  const LoginFailure({
    this.message,
  });
}
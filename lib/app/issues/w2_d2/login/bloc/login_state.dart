part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  final String email;
  final String password;

  const LoginInitial({
    this.email="",
    this.password="",
  });

  @override
  List<Object> get props => [email, password];

  LoginInitial copyWith({
    String? email,
    String? password,
  }) {
    return LoginInitial(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFail extends LoginState {}

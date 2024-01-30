part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class DoRegister extends RegisterEvent {
  final String name;
  final String phoneNumber;
  final String email;
  final String password;

  const DoRegister({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, phoneNumber, email, password];
}

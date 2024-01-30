part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, fail }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String name;
  final String email;
  final String phoneNumber;
  final String password;

  const RegisterState(
      {this.status = RegisterStatus.initial,
      this.name = "",
      this.email = "",
      this.phoneNumber = "",
      this.password = ""});

  @override
  List<Object?> get props => [status, name, email, phoneNumber, password];

  RegisterState copyWith({
    RegisterStatus? status,
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
  }) {
    return RegisterState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }
}

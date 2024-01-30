part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, fail }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String? message;
  const RegisterState(
      {this.status = RegisterStatus.initial, this.message});

  @override
  List<Object?> get props => [status];

  RegisterState copyWith({
    RegisterStatus? status,
    String? message,
  }) {
    return RegisterState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}

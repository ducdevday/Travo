part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class SaveField extends LoginEvent {
  final FieldType fieldType;
  final String input;

  const SaveField({
    required this.fieldType,
    required this.input,
  });

  @override
  List<Object> get props => [fieldType, input];
}

class DoLogin extends LoginEvent {
  const DoLogin();

  @override
  List<Object> get props => [];
}

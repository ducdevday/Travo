part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class SaveField extends RegisterEvent {
  final FieldType fieldType;
  final String input;

  const SaveField({
    required this.fieldType,
    required this.input,
  });

  @override
  List<Object> get props => [fieldType, input];
}

class DoRegister extends RegisterEvent {
  const DoRegister();

  @override
  List<Object> get props => [];
}

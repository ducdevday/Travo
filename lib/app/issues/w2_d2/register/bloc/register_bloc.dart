import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../register_form_page.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState()) {
    on<SaveField>(_onSaveField);
    on<DoRegister>(_onDoRegister);
  }

  FutureOr<void> _onSaveField(SaveField event, Emitter<RegisterState> emit) {
    if (event.fieldType == FieldType.NAME) {
      emit(state.copyWith(name: event.input));
    } else if (event.fieldType == FieldType.EMAIL) {
      emit(state.copyWith(email: event.input));
    } else if (event.fieldType == FieldType.PHONENUMBER) {
      emit(state.copyWith(phoneNumber: event.input));
    } else if (event.fieldType == FieldType.PASSWORD) {
      emit(state.copyWith(password: event.input));
    }
  }

  FutureOr<void> _onDoRegister(
      DoRegister event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      // DO Register
      await Future.delayed(Duration(seconds: 3));
      await doRegister(
          state.name, state.email, state.phoneNumber, state.password);
      emit(state.copyWith(status: RegisterStatus.success));
      EasyLoading.dismiss();
    } catch (_) {
      emit(state.copyWith(status: RegisterStatus.fail));
    }
  }

  Future<void> doRegister(
      String name, String email, String phoneNumber, String password) async {
    print(
        'User{name: $name, email: $email, phoneNumber: $phoneNumber, password: $password}');
  }
}

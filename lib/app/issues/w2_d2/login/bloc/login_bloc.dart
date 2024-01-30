import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../login_form_page.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<SaveField>(_onSaveField);
    on<DoLogin>(_onDoLogin);
  }

  FutureOr<void> _onSaveField(SaveField event, Emitter<LoginState> emit) {
    if (state is LoginInitial) {
      final currentState = state as LoginInitial;
      if (event.fieldType == FieldType.EMAIL) {
        emit(currentState.copyWith(email: event.input));
      } else if (event.fieldType == FieldType.PASSWORD) {
        emit(currentState.copyWith(password: event.input));
      }
    }
  }

  FutureOr<void> _onDoLogin(DoLogin event, Emitter<LoginState> emit) async {
    //! emit(LoginLoading());
    if (state is LoginInitial) {
      final currentState = state as LoginInitial;
      try {
        EasyLoading.show(maskType: EasyLoadingMaskType.black);
        // DO Login
        await Future.delayed(Duration(seconds: 3));
        await doLogin(currentState.email, currentState.password);
        emit(LoginSuccess());
        EasyLoading.dismiss();
      } catch (_) {
        //! emit(LoginFail());
        EasyLoading.showError("Login Fail");
      }
    }
  }

  Future<void> doLogin(String email, String password) async {
    print('User{email: $email, password: $password}');
  }
}

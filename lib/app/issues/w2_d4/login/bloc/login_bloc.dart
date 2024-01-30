import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_project/data/repositories/auth/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginInitial()) {
    on<DoLogin>(_onDoLogin);
  }

  FutureOr<void> _onDoLogin(DoLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      await doLogin(event.email, event.password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        emit(LoginFail(message: "User Not Found"));
      }
      else if(e.code == "wrong-password"){
        emit(LoginFail(message: "Wrong Password"));
      }
      else if(e.code == "invalid-credential"){
        emit(LoginFail(message: "Wrong Password"));
      }
    }
    catch (e) {
      emit(LoginFail());
    }
  }

  Future<void> doLogin(String email, String password) async {
    await _authRepository.signInWithEmailAndPassword(email, password);
  }
}

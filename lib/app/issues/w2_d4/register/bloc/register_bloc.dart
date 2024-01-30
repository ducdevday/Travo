import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_project/data/repositories/auth/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository _authRepository;

  RegisterBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(RegisterState()) {
    on<DoRegister>(_onDoRegister);
  }

  FutureOr<void> _onDoRegister(
      DoRegister event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(status: RegisterStatus.loading));
    try {
      await doRegister(
          event.name, event.email, event.phoneNumber, event.password);
      emit(state.copyWith(status: RegisterStatus.success));
    }
    on FirebaseAuthException catch (e){
      if(e.code == 'email-already-in-use'){
        emit(state.copyWith(status: RegisterStatus.fail, message: "Email Already In Use"));
      }
    }
    catch (e) {
      emit(state.copyWith(status: RegisterStatus.fail));
    }
  }

  Future<void> doRegister(
      String name, String email, String phoneNumber, String password) async {
    // await _authRepository.signUpWithEmailAndPassword(
    //     name, phoneNumber, email, password);
  }
}

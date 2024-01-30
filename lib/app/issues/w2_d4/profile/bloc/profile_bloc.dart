import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_project/data/repositories/auth/auth_repository.dart';
import 'package:my_project/data/repositories/user/user_repository.dart';

import '../profile_page.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  ProfileBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ProfileInitial()) {
    on<ProfileUserLoad>(_onProfileUserLoad);
    on<ProfileUserUpdate>(_onProfileUserUpdate);
  }

  FutureOr<void> _onProfileUserLoad(
      ProfileUserLoad event, Emitter<ProfileState> emit) async {
    try {
      EasyLoading.show();
      final result =
          await _userRepository.getUser(event.uid);
      EasyLoading.dismiss();
      // final User user = User.fromJson(result.data!);
      // emit(ProfileLoadSuccess(user: user));
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  FutureOr<void> _onProfileUserUpdate(ProfileUserUpdate event, Emitter<ProfileState> emit) async{
    try {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      print(event.user.toString());
      // await _userRepository.updateUser(event.uid, event.user);
      EasyLoading.dismiss();
      emit(ProfileLoadSuccess(user: event.user));
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }
}

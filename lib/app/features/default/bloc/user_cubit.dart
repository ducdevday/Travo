import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_project/data/model/user_model.dart';
import 'package:my_project/data/repositories/auth/auth_repository.dart';
import 'package:my_project/data/repositories/user/user_repository.dart';
import 'package:my_project/data/services/shared_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  final AuthRepository authRepository;
  UserCubit({required this.userRepository, required this.authRepository}) : super(UserInitial());

  void loadUser() async {
    if(SharedService.getUserId() == null) return;
    emit(UserLoadInProcess());
    try {
      final user = await userRepository.getUser(SharedService.getUserId()!);
      emit(UserLoadSuccess(user: user));
    } catch (e) {
      emit(UserLoadFailure());
    }
  }

  void updateUser(UserModel user) async {
    if (state is UserLoadSuccess) {
      final currentState = state as UserLoadSuccess;
      emit(currentState.copyWith(user: user));
    }
  }

  void logout() async {
    await authRepository.signOut();
  }

}

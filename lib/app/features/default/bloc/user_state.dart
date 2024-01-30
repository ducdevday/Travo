part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoadInProcess extends UserState {}

class UserLoadSuccess extends UserState {
  final UserModel user;

  const UserLoadSuccess({
    required this.user,
  });

  @override
  List<Object> get props => [user];

  UserLoadSuccess copyWith({
    UserModel? user,
  }) {
    return UserLoadSuccess(
      user: user ?? this.user,
    );
  }
}

class UserLoadFailure extends UserState {}

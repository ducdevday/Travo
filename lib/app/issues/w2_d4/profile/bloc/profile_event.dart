part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileUserLoad extends ProfileEvent {
  final String uid;

  const ProfileUserLoad({
    required this.uid,
  });

  @override
  List<Object> get props => [uid];
}

class ProfileUserUpdate extends ProfileEvent {
  final String uid;
  final User user;

  const ProfileUserUpdate({
    required this.uid,
    required this.user,
  });

  @override
  List<Object> get props => [uid, user];
}



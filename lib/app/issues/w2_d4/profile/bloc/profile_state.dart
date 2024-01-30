part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();

}
class ProfileLoadSuccess extends ProfileState {
  final User user;

  const ProfileLoadSuccess({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
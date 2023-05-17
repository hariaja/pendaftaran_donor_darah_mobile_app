part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserFailure extends UserState {
  final String e;
  const UserFailure(this.e);

  @override
  List<Object> get props => [e];
}

class UserSuccessLoaded extends UserState {
  final User user;
  const UserSuccessLoaded(this.user);

  @override
  List<Object> get props => [user];
}

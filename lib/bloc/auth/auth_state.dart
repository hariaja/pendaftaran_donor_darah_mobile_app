part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthFailure extends AuthState {
  final String e;
  const AuthFailure(this.e);

  @override
  List<Object> get props => [e];
}

class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthCheckEmailSuccess extends AuthState {}

class AuthCheckNikSuccess extends AuthState {}

class AuthCheckPhoneSuccess extends AuthState {}

class AuthRegisterSuccess extends AuthState {}

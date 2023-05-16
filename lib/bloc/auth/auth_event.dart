part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckEmail extends AuthEvent {
  final String email;
  const AuthCheckEmail(this.email);

  @override
  List<Object> get props => [email];
}

class AuthCheckNik extends AuthEvent {
  final String nik;
  const AuthCheckNik(this.nik);

  @override
  List<Object> get props => [nik];
}

class AuthCheckPhone extends AuthEvent {
  final String phone;
  const AuthCheckPhone(this.phone);

  @override
  List<Object> get props => [phone];
}

class AuthRegister extends AuthEvent {
  final SignUpForm data;
  const AuthRegister(this.data);

  @override
  List<Object> get props => [data];
}

class AuthLogin extends AuthEvent {
  final SignInForm data;
  const AuthLogin(this.data);

  @override
  List<Object> get props => [data];
}

class AuthGetCurrentUser extends AuthEvent {}

class AuthLogout extends AuthEvent {}

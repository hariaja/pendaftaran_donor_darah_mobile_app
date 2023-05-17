part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegsitrationLoading extends RegistrationState {}

class RegsitrationFailure extends RegistrationState {
  final String e;
  const RegsitrationFailure(this.e);

  @override
  List<Object> get props => [e];
}

class RegsitrationStoreSuccess extends RegistrationState {}

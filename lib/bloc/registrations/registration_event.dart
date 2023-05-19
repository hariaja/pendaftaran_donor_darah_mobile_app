part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class RegistrationIndex extends RegistrationEvent {}

class RegistrationStore extends RegistrationEvent {
  final RegistrationStoreForm data;
  const RegistrationStore(this.data);

  @override
  List<Object> get props => [data];
}

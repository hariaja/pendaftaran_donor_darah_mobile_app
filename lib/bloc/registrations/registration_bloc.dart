import 'package:bloc/bloc.dart';
import 'package:blood_donation_app/data/request/registration_store_form.dart';
import 'package:blood_donation_app/data/services/registration_service.dart';
import 'package:equatable/equatable.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) async {
      if (event is RegistrationStore) {
        try {
          emit(RegsitrationLoading());
          await RegistrationService().registrationStore(event.data);
          emit(RegsitrationStoreSuccess());
        } catch (e) {
          emit(RegsitrationFailure(e.toString()));
        }
      }
    });
  }
}

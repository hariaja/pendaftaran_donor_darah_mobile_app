import 'package:bloc/bloc.dart';
import 'package:blood_donation_app/data/models/user.dart';
import 'package:blood_donation_app/data/services/user_service.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is UserCurrentLogin) {
        try {
          emit(UserLoading());
          final user = await UserService().getUserLogin();
          emit(UserSuccessLoaded(user));
        } catch (e) {
          emit(UserFailure(e.toString()));
        }
      }
    });
  }
}

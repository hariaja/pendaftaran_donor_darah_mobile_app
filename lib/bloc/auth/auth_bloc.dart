import 'package:blood_donation_app/data/request/sign_up_form_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blood_donation_app/data/services/auth_service.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      // Check Email
      if (event is AuthCheckEmail) {
        try {
          emit(AuthLoading());
          final response = await AuthService().checkEmail(event.email);
          if (response == false) {
            emit(AuthCheckEmailSuccess());
          } else {
            emit(
              const AuthFailure(
                'Email sudah digunakan',
              ),
            );
          }
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }

      // Check Nik
      if (event is AuthCheckNik) {
        try {
          emit(AuthLoading());
          final response = await AuthService().checkNik(event.nik);
          if (response == false) {
            emit(AuthCheckNikSuccess());
          } else {
            emit(
              const AuthFailure(
                'Nomor Induk Kependudukan sudah digunakan',
              ),
            );
          }
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }

      // Check phone
      if (event is AuthCheckPhone) {
        try {
          emit(AuthLoading());
          final response = await AuthService().checkPhone(event.phone);
          if (response == false) {
            emit(AuthCheckPhoneSuccess());
          } else {
            emit(
              const AuthFailure(
                'Nomor Telepon sudah digunakan',
              ),
            );
          }
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }

      // Register User
      if (event is AuthRegister) {
        try {
          emit(AuthLoading());
          await AuthService().registerUsers(event.data);
          emit(AuthRegisterSuccess());
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }
    });
  }
}

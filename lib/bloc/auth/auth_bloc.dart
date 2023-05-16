import 'package:blood_donation_app/data/models/user.dart';
import 'package:blood_donation_app/data/request/sign_in_form_model.dart';
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

      // Login User
      if (event is AuthLogin) {
        try {
          emit(AuthLoading());
          final user = await AuthService().loginUsers(event.data);
          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }

      // Get current credential
      if (event is AuthGetCurrentUser) {
        try {
          emit(AuthLoading());

          final SignInForm data = await AuthService().getCredentialFromLocal();
          final User user = await AuthService().loginUsers(data);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }

      // Logout User
      if (event is AuthLogout) {
        try {
          emit(AuthLoading());
          await AuthService().logout();
          emit(AuthInitial());
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }
    });
  }
}

import 'package:blood_donation_app/bloc/auth/auth_bloc.dart';
import 'package:blood_donation_app/bloc/registrations/registration_bloc.dart';
import 'package:blood_donation_app/bloc/users/user_bloc.dart';
import 'package:blood_donation_app/screens/auth/signin/sign_in_page.dart';
import 'package:blood_donation_app/screens/auth/signup/sign_up_page_one.dart';
import 'package:blood_donation_app/screens/home/main_page.dart';
import 'package:blood_donation_app/screens/registrations/store_registration_page.dart';
import 'package:blood_donation_app/screens/splash/splash_page.dart';
import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(AuthGetCurrentUser()),
        ),
        BlocProvider(
          create: (context) => UserBloc()..add(UserCurrentLogin()),
        ),
        BlocProvider(
          create: (context) => RegistrationBloc()..add(RegistrationIndex()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: bgLight,
        ),
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const MainPage(),
          '/sign-in': (context) => const SignInPage(),
          '/sign-up-one': (context) => const SignUpPageOne(),
          '/store-registration': (context) => const StoreRegistrationPage(),
        },
      ),
    );
  }
}

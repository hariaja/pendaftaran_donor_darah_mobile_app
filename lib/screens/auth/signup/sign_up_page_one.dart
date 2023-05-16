import 'package:blood_donation_app/bloc/auth/auth_bloc.dart';
import 'package:blood_donation_app/data/request/sign_up_form_model.dart';
import 'package:blood_donation_app/screens/auth/signup/sign_up_page_two.dart';
import 'package:blood_donation_app/themes/theme.dart';
import 'package:blood_donation_app/utils/method.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:blood_donation_app/widgets/button_action.dart';
import 'package:blood_donation_app/widgets/button_loading.dart';
import 'package:blood_donation_app/widgets/footer_auth.dart';
import 'package:blood_donation_app/widgets/form_input.dart';
import 'package:blood_donation_app/widgets/header_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpPageOne extends StatefulWidget {
  const SignUpPageOne({super.key});

  @override
  State<SignUpPageOne> createState() => _SignUpPageOneState();
}

class _SignUpPageOneState extends State<SignUpPageOne> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  bool _obsecurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderAuth(
                  title: 'Buat Akun',
                  subtitle: 'Lengkapi data dan buat kredensial anda',
                ),
                const SizedBox(
                  height: 70,
                ),
                CustomFilledForm(
                  title: 'Nama',
                  hintText: 'Masukkan nama lengkap',
                  iconPath: 'assets/icons/ic_user.png',
                  controller: _nameController,
                  validator: MultiValidator([
                    RequiredValidator(errorText: requireForm),
                    MaxLengthValidator(16, errorText: maxLength),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFilledForm(
                  title: 'Email',
                  hintText: 'Masukkan email',
                  iconPath: 'assets/icons/ic_mail.png',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: MultiValidator([
                    RequiredValidator(
                      errorText: requireForm,
                    ),
                    EmailValidator(
                      errorText: notValidForm,
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFilledForm(
                  title: 'Password',
                  hintText: 'Masukkan password',
                  iconPath: 'assets/icons/ic_lock.png',
                  obsecureText: _obsecurePassword,
                  controller: _passwordController,
                  validator: MultiValidator([
                    RequiredValidator(
                      errorText: 'Password tidak boleh kosong',
                    ),
                    MinLengthValidator(
                      6,
                      errorText: 'Password minimal 6 karakter',
                    ),
                    MaxLengthValidator(
                      15,
                      errorText: 'Password maksimal 15 karakter',
                    ),
                    PatternValidator(
                      r'(?=.*?[#?!@$%^&*-])',
                      errorText:
                          'Password minimal harus memiliki 1 karakter special',
                    ),
                  ]),
                  iconButton: IconButton(
                    padding: const EdgeInsets.only(right: 16),
                    icon: Icon(
                      _obsecurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        _obsecurePassword = !_obsecurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFilledForm(
                  title: 'Confirm Password',
                  hintText: 'Your Confirm Password',
                  iconPath: 'assets/icons/ic_lock.png',
                  obsecureText: true,
                  controller: _passwordConfirmationController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password Konfirmasi tidak boleh kosong';
                    }
                    return MatchValidator(
                      errorText:
                          'Password Konfirmasi tidak sama dengan password',
                    ).validateMatch(
                      value,
                      _passwordController.text,
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthCheckEmailSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPageTwo(
                            data: SignUpForm(
                              name: _nameController.text,
                              nik: '',
                              gender: '',
                              bloodTypeId: '',
                              rhesus: '',
                              birthDate: '',
                              jobTitle: '',
                              phone: '',
                              email: _emailController.text,
                              password: _passwordController.text,
                              passwordConfirmation:
                                  _passwordConfirmationController.text,
                              address: '',
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is AuthFailure) {
                      errorSnackbar(context, state.e);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const ButtonLoading();
                    }

                    return ButtonAction(
                      title: 'Selanjutnya',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                                AuthCheckEmail(
                                  _emailController.text,
                                ),
                              );
                        }
                      },
                    );
                  },
                ),
                const Spacer(),
                FooterAuth(
                  title: 'Sudah memiliki akun? ',
                  subtitle: 'Masuk Aplikasi',
                  onTap: () {
                    Navigator.pushNamed(context, '/sign-in');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

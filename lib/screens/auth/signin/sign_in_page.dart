import 'package:blood_donation_app/themes/theme.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:blood_donation_app/widgets/button_action.dart';
import 'package:blood_donation_app/widgets/footer_auth.dart';
import 'package:blood_donation_app/widgets/form_input.dart';
import 'package:blood_donation_app/widgets/header_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
                  title: 'Masuk Aplikasi',
                  subtitle: 'Masukkan email dan password untuk melanjutkan',
                ),
                const SizedBox(
                  height: 70,
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
                  validator: RequiredValidator(
                    errorText: requireForm,
                  ),
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
                  height: 40,
                ),
                const ButtonAction(
                  title: 'Masuk Aplikasi',
                ),
                const Spacer(),
                FooterAuth(
                  title: 'Belum memiliki akun? ',
                  subtitle: 'Buat Akun Baru',
                  onTap: () {
                    Navigator.pushNamed(context, '/sign-up-one');
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

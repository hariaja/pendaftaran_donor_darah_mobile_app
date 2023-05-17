import 'package:blood_donation_app/bloc/auth/auth_bloc.dart';
import 'package:blood_donation_app/data/request/sign_up_form_model.dart';
import 'package:blood_donation_app/screens/auth/signup/sign_up_page_three.dart';
import 'package:blood_donation_app/themes/theme.dart';
import 'package:blood_donation_app/utils/method.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:blood_donation_app/widgets/button_action.dart';
import 'package:blood_donation_app/widgets/button_loading.dart';
import 'package:blood_donation_app/widgets/form_input.dart';
import 'package:blood_donation_app/widgets/header_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpPageTwo extends StatefulWidget {
  final SignUpForm data;

  const SignUpPageTwo({
    super.key,
    required this.data,
  });

  @override
  State<SignUpPageTwo> createState() => _SignUpPageTwoState();
}

class _SignUpPageTwoState extends State<SignUpPageTwo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nikController = TextEditingController();
  final _jobController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  List<String> genders = [
    male,
    female,
  ];

  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Form(
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
                      title: 'Nik',
                      hintText: 'Your Nik',
                      iconPath: 'assets/icons/ic_union.png',
                      keyboardType: TextInputType.number,
                      controller: _nikController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[0-9]"),
                        )
                      ],
                      validator: MultiValidator([
                        RequiredValidator(
                          errorText: 'Nik tidak boleh kosong',
                        ),
                        MinLengthValidator(
                          16,
                          errorText:
                              'Nik tidak lebih atau kurang dari 16 karakter',
                        ),
                        MaxLengthValidator(
                          16,
                          errorText:
                              'Nik tidak lebih atau kurang dari 16 karakter',
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Jenis Kelamin',
                      style: darkTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    DropdownButtonFormField(
                      validator: (value) {
                        if (value == '') {
                          return 'Pilih jenis kelamin';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Select Your Gender',
                        hintStyle: secondaryTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        filled: true,
                        fillColor: formLight,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 10,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Image.asset(
                            'assets/icons/ic_hexagon.png',
                            width: 17,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      value: selectedGender,
                      onChanged: (newValue) {
                        setState(() {
                          selectedGender = newValue;
                        });
                      },
                      items: genders.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // TODO: This date brith picker
                    Text(
                      'Tanggal Lahir',
                      style: darkTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        hintText: 'Pick Your Date of Birth',
                        hintStyle: secondaryTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        suffixIcon: IconButton(
                          icon: Image.asset(
                            width: 18,
                            'assets/icons/ic_calendar.png',
                          ),
                          color: primaryColor,
                          onPressed: () => _selectDate(context),
                        ),
                        filled: true,
                        fillColor: formLight,
                      ),
                      readOnly: true,
                      validator: (value) {
                        if (value == '') {
                          return 'Pilih tanggal lahir';
                        }
                        return null;
                      },
                    ),
                    // TODO: This date brith picker

                    const SizedBox(
                      height: 20,
                    ),

                    CustomFilledForm(
                      title: 'Pekerjaan',
                      hintText: 'Masukkan pekerjaan anda',
                      iconPath: 'assets/icons/ic_coffee.png',
                      controller: _jobController,
                      validator: MultiValidator([
                        RequiredValidator(
                          errorText: 'Pekerjaan tidak boleh kosong',
                        ),
                      ]),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthFailure) {
                          errorSnackbar(context, state.e);
                        }

                        if (state is AuthCheckNikSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPageThree(
                                data: widget.data.copyWith(
                                  nik: _nikController.text,
                                  gender: selectedGender,
                                  birthDate: _dateController.text,
                                  jobTitle: _jobController.text,
                                ),
                              ),
                            ),
                          );
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
                                    AuthCheckNik(
                                      _nikController.text,
                                    ),
                                  );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

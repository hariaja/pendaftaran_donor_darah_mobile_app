import 'dart:convert';

import 'package:blood_donation_app/bloc/auth/auth_bloc.dart';
import 'package:blood_donation_app/data/request/sign_up_form_model.dart';
import 'package:blood_donation_app/themes/theme.dart';
import 'package:blood_donation_app/utils/method.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:blood_donation_app/widgets/button_action.dart';
import 'package:blood_donation_app/widgets/button_loading.dart';
import 'package:blood_donation_app/widgets/form_input.dart';
import 'package:blood_donation_app/widgets/header_auth.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;

class SignUpPageThree extends StatefulWidget {
  final SignUpForm data;

  const SignUpPageThree({
    super.key,
    required this.data,
  });

  @override
  State<SignUpPageThree> createState() => _SignUpPageThreeState();
}

class _SignUpPageThreeState extends State<SignUpPageThree> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  List<String> rhesus = [
    positif,
    negatif,
    unknown,
  ];

  String? selectedRhesus;

  List _get = [];
  String bloodTypes = '';
  int? bloodTypesId;

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
                      title: 'Telepon',
                      hintText: 'Masukkan nomor telepon',
                      iconPath: 'assets/icons/ic_smartphone.png',
                      keyboardType: TextInputType.phone,
                      controller: _phoneController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r"[0-9]"),
                        )
                      ],
                      validator: MultiValidator([
                        RequiredValidator(
                          errorText: 'Telepon tidak boleh kosong',
                        ),
                        MinLengthValidator(
                          12,
                          errorText: 'Telepon minimal 12 Karakter',
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // TODO: Blood type select
                    Text(
                      'Golongan Darah',
                      style: darkTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    DropdownSearch<dynamic>(
                      dropdownSearchDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        hintText: 'Your Blood Type',
                        hintStyle: secondaryTextStyle.copyWith(
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Image.asset(
                            'assets/icons/ic_share.png',
                            width: 17,
                          ),
                        ),
                      ),
                      mode: Mode.MENU,
                      showSearchBox: true,
                      onFind: (text) async {
                        // Get Api Response
                        var response = await http.get(
                          Uri.parse(
                            "$baseUrl/users/blood-types",
                          ),
                        );

                        // Cek If Response Success
                        if (response.statusCode == 200) {
                          final data = jsonDecode(response.body);
                          setState(() {
                            _get = data['data'];
                          });
                        }

                        return _get;
                      },

                      onChanged: (value) {
                        setState(() {
                          bloodTypes = value['type'];
                          bloodTypesId = value['id'];
                        });
                      },

                      //this data appear in dropdown after clicked
                      itemAsString: (item) => item['type'],
                    ),
                    // TODO: Blood type select
                    const SizedBox(
                      height: 20,
                    ),

                    // TODO: Rhesus select
                    Text(
                      'Rhesus',
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
                          return 'Pilih rhesus terlebih dahulu';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Silahkan pilih rhesus',
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
                            'assets/icons/ic_plus.png',
                            width: 17,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      value: selectedRhesus,
                      onChanged: (newValue) {
                        setState(() {
                          selectedRhesus = newValue;
                        });
                      },
                      items: rhesus.map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                    ),
                    // TODO: Rhesus select
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFilledForm(
                      title: 'Alamat',
                      hintText: 'Masukkan alamat anda',
                      iconPath: 'assets/icons/ic_truck.png',
                      controller: _addressController,
                      validator: MultiValidator([
                        RequiredValidator(
                          errorText: 'Alamat tidak boleh kosong',
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

                        if (state is AuthRegisterSuccess) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/sign-in',
                            (route) => false,
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return const ButtonLoading();
                        }

                        return ButtonAction(
                          title: 'Selesaikan Pendaftaran',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthRegister(
                                      widget.data.copyWith(
                                        phone: _phoneController.text,
                                        bloodTypeId: bloodTypesId.toString(),
                                        rhesus: selectedRhesus,
                                        address: _addressController.text,
                                      ),
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

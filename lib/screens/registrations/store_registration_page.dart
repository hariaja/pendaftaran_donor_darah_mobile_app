import 'package:blood_donation_app/bloc/registrations/registration_bloc.dart';
import 'package:blood_donation_app/bloc/users/user_bloc.dart';
import 'package:blood_donation_app/data/request/registration_store_form.dart';
import 'package:blood_donation_app/themes/theme.dart';
import 'package:blood_donation_app/utils/method.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:blood_donation_app/widgets/button_action.dart';
import 'package:blood_donation_app/widgets/button_loading.dart';
import 'package:blood_donation_app/widgets/error_page.dart';
import 'package:blood_donation_app/widgets/item_store_registration.dart';
import 'package:blood_donation_app/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreRegistrationPage extends StatefulWidget {
  const StoreRegistrationPage({super.key});

  @override
  State<StoreRegistrationPage> createState() => _StoreRegistrationPageState();
}

class _StoreRegistrationPageState extends State<StoreRegistrationPage> {
  final _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  String? urgency;
  String? ramadan;

  bool validate() {
    if (urgency == null || ramadan == null) {
      return false;
    }

    return true;
  }

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

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: primaryLightColor,
        centerTitle: true,
        title: Text(
          'Buat Pendaftaran',
          style: darkTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left_rounded,
            color: darkText,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const LoadingPage();
          } else if (state is UserSuccessLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                BlocProvider.of<UserBloc>(context).add(UserCurrentLogin());
              },
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: state.user.hasAvatar == false
                            ? NetworkImage(state.user.avatarUrl!)
                            : NetworkImage(
                                '$baseStorage/${state.user.avatarUrl!}',
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  ItemStoreRegistration(
                    title: 'Usia',
                    value: '${state.user.donor!.age} Tahun',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ItemStoreRegistration(
                    title: 'Lahir',
                    value: state.user.birthDate!,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ItemStoreRegistration(
                    title: 'Golongan Darah',
                    value: state.user.donor!.bloodType!.type!,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ItemStoreRegistration(
                    title: 'Rhesus',
                    value: state.user.donor!.rhesus!,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // TODO: Date picker
                  Text(
                    'Terakhir Melakukan Donor',
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
                      hintText: 'TTTT-BB-HH',
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
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Kosongkan jika belum pernah',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 10,
                    ),
                  ),
                  // TODO: Date picker
                  const SizedBox(
                    height: 20,
                  ),
                  // TODO: URGENCY
                  Text(
                    'Apakah anda bersedia melakukan donor pada waktu tertentu? (Di luar donor rutin)',
                    style: darkTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'Ya',
                        groupValue: urgency,
                        onChanged: (value) {
                          setState(() {
                            urgency = value.toString();
                          });
                        },
                      ),
                      Text(
                        'Ya',
                        style: darkTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Radio(
                        value: 'Tidak',
                        groupValue: urgency,
                        onChanged: (value) {
                          setState(() {
                            urgency = value.toString();
                          });
                        },
                      ),
                      Text(
                        'Tidak',
                        style: darkTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Pilih salah satu (Wajib)',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 10,
                    ),
                  ),
                  // TODO: URGENCY
                  const SizedBox(
                    height: 20,
                  ),
                  // TODO: RAMADAN
                  Text(
                    'Apakah anda bersedia melakukan donor pada bulan puasa?',
                    style: darkTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Radio(
                        value: 'Ya',
                        groupValue: ramadan,
                        onChanged: (value) {
                          setState(() {
                            ramadan = value.toString();
                          });
                        },
                      ),
                      Text(
                        'Ya',
                        style: darkTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Radio(
                        value: 'Tidak',
                        groupValue: ramadan,
                        onChanged: (value) {
                          setState(() {
                            ramadan = value.toString();
                          });
                        },
                      ),
                      Text(
                        'Tidak',
                        style: darkTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: medium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Pilih salah satu (Wajib)',
                    style: secondaryTextStyle.copyWith(
                      fontSize: 10,
                    ),
                  ),
                  // TODO: RAMADAN
                  const SizedBox(
                    height: 40,
                  ),
                  BlocConsumer<RegistrationBloc, RegistrationState>(
                    listener: (context, state) {
                      if (state is RegsitrationFailure) {
                        errorSnackbar(context, state.e);
                      }

                      if (state is RegsitrationStoreSuccess) {
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      if (state is RegsitrationLoading) {
                        return const ButtonLoading();
                      }

                      return ButtonAction(
                        title: 'Submit Pendaftaran',
                        onPressed: () {
                          context.read<RegistrationBloc>().add(
                                RegistrationStore(
                                  RegistrationStoreForm(
                                    lastDonor: _dateController.text,
                                    ramadan: ramadan,
                                    urgency: urgency,
                                  ),
                                ),
                              );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            );
          } else {
            return const ErrorPage();
          }
        },
      ),
    );
  }
}

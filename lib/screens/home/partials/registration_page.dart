import 'package:blood_donation_app/bloc/registrations/registration_bloc.dart';
import 'package:blood_donation_app/themes/theme.dart';
import 'package:blood_donation_app/widgets/empty_page.dart';
import 'package:blood_donation_app/widgets/error_page.dart';
import 'package:blood_donation_app/widgets/list_registrations.dart';
import 'package:blood_donation_app/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: primaryLightColor,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Histori Pendaftaran',
          style: darkTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.add,
        //       color: lightText,
        //     ),
        //   ),
        // ],
      );
    }

    Widget emptyRegistrations() {
      return EmptyPage(
        title: 'Opss! Pendaftaran Anda Kosong',
        subtitle: 'Silahkan tambahkan di halaman tambah registrasi',
        buttonTitle: 'Buat Pendaftaran',
        onPressed: () {
          Navigator.pushNamed(context, '/store-registration');
        },
      );
    }

    return Scaffold(
      appBar: header(),
      body: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          if (state is RegsitrationLoading) {
            return const LoadingPage();
          }

          if (state is RegistrationIndexSuccess) {
            if (state.registrations.isEmpty == true) {
              return Center(
                child: emptyRegistrations(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<RegistrationBloc>(context).add(
                    RegistrationIndex(),
                  );
                },
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: defaultMargin),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daftar Pengajuan Donor Darah',
                            style: darkTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: state.registrations.map((registration) {
                              return ListRegistrations(
                                registration: registration,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }

          return const ErrorPage();
        },
      ),
    );
  }
}

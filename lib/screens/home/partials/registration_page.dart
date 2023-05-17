import 'package:blood_donation_app/themes/theme.dart';
import 'package:blood_donation_app/widgets/empty_page.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
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

    return Scaffold(
      body: Column(
        children: [
          header(),
          EmptyPage(
            title: 'Opss! Pendaftaran Anda Kosong',
            subtitle: 'Silahkan menambahkan data pendaftaran \nTerlebih dahulu',
            buttonTitle: 'Buat Pendaftaran',
            onPressed: () {
              Navigator.pushNamed(context, '/store-registration');
            },
          ),
        ],
      ),
    );
  }
}

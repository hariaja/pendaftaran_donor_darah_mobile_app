import 'package:blood_donation_app/bloc/auth/auth_bloc.dart';
import 'package:blood_donation_app/themes/theme.dart';
import 'package:blood_donation_app/utils/method.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:blood_donation_app/widgets/IndicatorLoading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Menu settings
    Widget menuItem(String text) {
      return Container(
        // margin: const EdgeInsets.only(top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: secondaryTextStyle.copyWith(
                fontSize: 13,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: grayText,
            )
          ],
        ),
      );
    }
    // TODO: Menu settings

    // TODO: Header settings
    BlocConsumer<AuthBloc, AuthState> header() {
      return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            errorSnackbar(context, state.e);
          }

          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/sign-in',
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return AppBar(
              backgroundColor: appBarLight,
              automaticallyImplyLeading: false,
              elevation: 0,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(
                    defaultMargin,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IndicatorLoading(
                          width: 16,
                          height: 16,
                          color: darkText,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Loading',
                          style: darkTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is AuthSuccess) {
            return Column(
              children: [
                AppBar(
                  backgroundColor: appBarLight,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  flexibleSpace: SafeArea(
                    child: Container(
                      padding: EdgeInsets.all(defaultMargin),
                      child: Row(
                        children: [
                          ClipOval(
                            child: state.user.hasAvatar == false
                                ? Image.network(
                                    '$baseStorage/assets/images/default.png',
                                    width: 64,
                                  )
                                : Image.network(
                                    '$baseStorage${state.user.avatarUrl}',
                                    width: 64,
                                  ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.user.name!,
                                  style: darkTextStyle.copyWith(
                                    fontSize: 24,
                                    fontWeight: semiBold,
                                  ),
                                ),
                                Text(
                                  state.user.email!,
                                  style: secondaryTextStyle.copyWith(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<AuthBloc>().add(AuthLogout());
                            },
                            child: Image.asset(
                              'assets/icons/ic_logout.png',
                              width: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return AppBar(
              backgroundColor: appBarLight,
              automaticallyImplyLeading: false,
              elevation: 0,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(
                    defaultMargin,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.close,
                          color: darkText,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Something went error',
                          style: darkTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      );
    }
    // TODO: Header settings

    return Scaffold(
      body: Column(
        children: [
          header(),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: defaultMargin,
              ),
              decoration: BoxDecoration(
                color: bgLight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Pengaturan Akun',
                    style: darkTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: menuItem(
                      'Avatar',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: menuItem(
                      'Data Diri',
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: menuItem(
                      'Kata Sandi',
                    ),
                  ),
                  SizedBox(
                    height: defaultMargin,
                  ),
                  Text(
                    'General',
                    style: darkTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  menuItem(
                    'Privacy & Policy',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  menuItem(
                    'Term of Service',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  menuItem(
                    'Rate App',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  menuItem(
                    'About Us',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

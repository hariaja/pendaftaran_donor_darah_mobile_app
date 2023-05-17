import 'package:blood_donation_app/bloc/auth/auth_bloc.dart';
import 'package:blood_donation_app/themes/theme.dart';
import 'package:blood_donation_app/values/string.dart';
import 'package:blood_donation_app/widgets/error_page.dart';
import 'package:blood_donation_app/widgets/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const LoadingPage();
        } else if (state is AuthSuccess) {
          final dateFormat = DateFormat('dd/MM/yyyy');
          final dateBirth = dateFormat.format(
            DateTime.parse(state.user.donor!.birthDate!),
          );
          return RefreshIndicator(
            onRefresh: () async {
              BlocProvider.of<AuthBloc>(context).add(AuthGetCurrentUser());
            },
            child: ListView(
              children: [
                // TODO: HEADER
                Container(
                  margin: EdgeInsets.only(
                    top: defaultMargin,
                    left: defaultMargin,
                    right: defaultMargin,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Howdy, ${state.user.name}',
                              style: primaryTextStyle.copyWith(
                                fontSize: 24,
                                fontWeight: semiBold,
                              ),
                            ),
                            Text(
                              '${state.user.email}',
                              style: secondaryTextStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 54,
                        width: 54,
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
                    ],
                  ),
                ),
                // TODO: HEADER

                // TODO: CARD
                Container(
                  width: double.infinity,
                  height: 220,
                  margin: const EdgeInsets.only(
                    top: 32,
                    left: 24,
                    right: 24,
                  ),
                  padding: EdgeInsets.all(defaultMargin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/images/bg_card.png',
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user.name.toString(),
                        style: lightTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal Lahir',
                                  style: lightTextStyle.copyWith(
                                    fontSize: 10,
                                    fontWeight: light,
                                  ),
                                ),
                                Text(
                                  dateBirth,
                                  style: lightTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jenis Kelamin',
                                  style: lightTextStyle.copyWith(
                                    fontSize: 10,
                                    fontWeight: light,
                                  ),
                                ),
                                Text(
                                  '${state.user.donor!.gender}',
                                  style: lightTextStyle.copyWith(
                                    fontSize: 20,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Golongan Darah',
                            style: lightTextStyle,
                          ),
                          Text(
                            '${state.user.donor?.bloodType?.type}',
                            style: lightTextStyle.copyWith(
                              fontSize: 24,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // TODO: CARD
              ],
            ),
          );
        } else {
          return const ErrorPage();
        }
      },
    );
  }
}

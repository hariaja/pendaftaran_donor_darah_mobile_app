import 'package:blood_donation_app/screens/home/partials/home_page.dart';
import 'package:blood_donation_app/screens/home/partials/registration_page.dart';
import 'package:blood_donation_app/screens/home/partials/schedule_page.dart';
import 'package:blood_donation_app/screens/home/partials/setting_page.dart';
import 'package:blood_donation_app/themes/theme.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: customNavBar(),
      body: customBody(),
    );
  }

  Widget customNavBar() {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(defaultMargin),
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          backgroundColor: formLight,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (value) => {
            setState(
              () => currentIndex = value,
            ),
          },
          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Image.asset(
                  'assets/icons/ic_home.png',
                  width: 21,
                  color:
                      currentIndex == 0 ? bottomNavActive : bottomNavInactive,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Image.asset(
                  'assets/icons/ic_file.png',
                  width: 20,
                  color:
                      currentIndex == 1 ? bottomNavActive : bottomNavInactive,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Image.asset(
                  'assets/icons/ic_calendar.png',
                  width: 20,
                  color:
                      currentIndex == 2 ? bottomNavActive : bottomNavInactive,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: Image.asset(
                  'assets/icons/ic_settings.png',
                  width: 18,
                  color:
                      currentIndex == 3 ? bottomNavActive : bottomNavInactive,
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget customBody() {
    switch (currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const RegistrationPage();
      case 2:
        return const SchedulePage();
      case 3:
        return const SettingPage();
      default:
        return const HomePage();
    }
  }
}

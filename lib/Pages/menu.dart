import 'package:dpc_flutter/Pages/Settings_Page.dart';
import 'package:dpc_flutter/Pages/login_page.dart';
import 'package:dpc_flutter/Pages/sign_up_page.dart';
import 'package:dpc_flutter/Pages/Home_Page.dart';
import 'package:dpc_flutter/Pages/My_carsPage.dart';

import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int index = 0;
  final Pages = [
    HomePage(),
    MyCars(),
    SettingsPage(),
    Center(child: Text('profile'))
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Pages[index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          height: 60,
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home,
                    color: Color.fromARGB(255, 30, 65, 239), size: 35),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.directions_car_outlined),
                selectedIcon: Icon(Icons.directions_car,
                    color: Color.fromARGB(255, 30, 65, 239), size: 35),
                label: 'My Cars'),
            NavigationDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings,
                    color: Color.fromARGB(255, 30, 65, 239), size: 35),
                label: 'Settings'),
            NavigationDestination(
                icon: Icon(Icons.person_outlined),
                selectedIcon: Icon(Icons.person,
                    color: Color.fromARGB(255, 30, 65, 239), size: 35),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

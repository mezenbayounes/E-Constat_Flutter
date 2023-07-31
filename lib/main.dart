import 'package:dpc_flutter/Pages/Add_Car.dart';
import 'package:dpc_flutter/Pages/CarDmageB.dart';
import 'package:dpc_flutter/Pages/menu.dart';
import 'package:flutter/material.dart';
import 'Pages/CarDamageA.dart';
import 'Pages/Scanqr.dart';
import 'Pages/login_page.dart';
import 'Pages/Settings_Page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool _iconBool = false;

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(_iconBool);
    return MaterialApp(
      routes: {
        "/": (context) => LoginPage(),
        "/menu": (context) => const Menu(index: 0),
        "/addCar": (context) => const AddCar(),
        '/CarDamageA': (context) => CarDamageA(),
        '/CarDamageB': (context) => CarDamageB(),
        '/scanqr': (context) => ScanScreen(),

      },
      initialRoute: "/",
      theme: _iconBool ? _darktheme : _lighttheme,
    );
  }
}

ThemeData _darktheme = ThemeData(
    primaryColor: Color.fromARGB(255, 166, 181, 34),
    brightness: Brightness.dark);

ThemeData _lighttheme = ThemeData(
    primaryColor: Color.fromARGB(255, 30, 65, 239),
    brightness: Brightness.light);

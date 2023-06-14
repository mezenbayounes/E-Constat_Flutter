import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dpc_flutter/components/My_Button_Settings.dart';



class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  void visible() {}
  @override
  Widget build(BuildContext context) {
      const  moonIcon = CupertinoIcons.moon_stars;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
          child: Center(
              child: Column(
        children: [
//Logo
          Image.asset(
            'lib/images/car_accesories_pana.png',
            height: 300,
          ),
          My_Button_Settings(
              onTap: visible,
              text: 'General Settings',
              icon: Icons.arrow_forward_ios_rounded),
          Divider(
            color: Colors.grey[700],
            height: 0,
            thickness: 2,
          ),
          
        ],
      ))),
    );
  }
}

  
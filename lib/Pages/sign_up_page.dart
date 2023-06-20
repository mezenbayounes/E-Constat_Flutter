import 'dart:convert';

import 'package:dpc_flutter/Pages/Settings_Page.dart';
import 'package:dpc_flutter/Pages/menu.dart';
import 'package:dpc_flutter/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:dpc_flutter/components/My_text_filed.dart';
import 'package:dpc_flutter/components/Pwd_text_filed.dart';
import 'package:dpc_flutter/components/My_button.dart';
import 'package:http/http.dart' as http;
import 'package:dpc_flutter/constant/utils.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool _isNotValidate = false;

  void Sing_Up() {}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            Image.asset('lib/images/mobile_login_amico.png'),
            My_text_filed(
                
                hintText: 'First Name',
                obsecureText: false,
                icon: Icons.person),
            const SizedBox(height: 10),
            My_text_filed(
                
                hintText: 'Last Name',
                obsecureText: false,
                icon: Icons.person),
            const SizedBox(height: 10),
            My_text_filed(
              
                hintText: 'Exp:email@gmail.com',
                obsecureText: false,
                icon: Icons.email),
            const SizedBox(height: 10),
            PasswordTextField(),
            const SizedBox(height: 10),
            My_text_filed(
               
                hintText: 'Adress',
                obsecureText: false,
                icon: Icons.location_pin),
            const SizedBox(height: 10),
            My_text_filed(
              
                hintText: 'Driver Licence',
                obsecureText: false,
                icon: Icons.badge_outlined),
            const SizedBox(height: 20),
            My_button(onTap: Sing_Up, text: 'Sign Up'),
            const SizedBox(height: 30),
          ],
        )),
      ),
    );
  }
}

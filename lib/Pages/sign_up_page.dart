import 'dart:convert';

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
  final FirstNameController = TextEditingController();
  final LastNameController = TextEditingController();
  final AdressController = TextEditingController();
  final DriverLicenceController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isNotValidate = false;

  void Sing_Up() {}

  /*void registerUser() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        FirstNameController.text.isNotEmpty &&
        LastNameController.text.isNotEmpty &&
        AdressController.text.isNotEmpty &&
        DriverLicenceController.text.isNotEmpty) {
      var regBody = {
        "name": FirstNameController.text,
        "lastName": LastNameController,
        "adress": AdressController,
        "driverLicense": DriverLicenceController,
        "email": emailController.text,
        "password": passwordController.text
      };
      var response = await http.post(Uri.parse(Utils.registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        print("SomeThing Went Wrong");
      }
    } else {
      setState(() {
        _isNotValidate = true;
        print('&&&&&&&&&&&&&&&&&');
      });
    }
  }
*/
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
                controller: FirstNameController,
                hintText: 'First Name',
                obsecureText: false,
                icon: Icons.person),
            const SizedBox(height: 10),
            My_text_filed(
                controller: LastNameController,
                hintText: 'Last Name',
                obsecureText: false,
                icon: Icons.person),
            const SizedBox(height: 10),
            My_text_filed(
                controller: emailController,
                hintText: 'Exp:email@gmail.com',
                obsecureText: false,
                icon: Icons.email),
            const SizedBox(height: 10),
            PasswordTextField(),
            const SizedBox(height: 10),
            My_text_filed(
                controller: AdressController,
                hintText: 'Adress',
                obsecureText: false,
                icon: Icons.location_pin),
            const SizedBox(height: 10),
            My_text_filed(
                controller: DriverLicenceController,
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

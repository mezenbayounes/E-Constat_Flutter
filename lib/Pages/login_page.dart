import 'package:dpc_flutter/Pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:dpc_flutter/components/My_Box.dart';
import 'package:dpc_flutter/components/My_button.dart';
import 'package:dpc_flutter/components/My_text_filed.dart';
import 'package:dpc_flutter/components/Pwd_text_filed.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final userNameController = TextEditingController();
  final pwdController = TextEditingController();
  void SingIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Column(
      children: [
        const SizedBox(height: 80),
//Logo
        Image.asset('lib/images/e_constat_logo.png'),

        const SizedBox(height: 50),
// text welcome
        Text(
          'Welcome To E-Constat ',
          style: TextStyle(color: Colors.grey[800], fontSize: 26),
        ),
        const SizedBox(height: 50),
//user name text filed
        My_text_filed(
          controller: userNameController,
          hintText: 'User name',
          obsecureText: false,
          icon: Icons.person,
        ),
//user pwd text filed
        const SizedBox(height: 10),
        PasswordTextField(),

        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Forgot password  ? ',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
// boutton Login
        My_button(onTap: SingIn),
        const SizedBox(height: 8),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: Text('New around here?', style: TextStyle(fontSize: 18)),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUp()),
              ), // Navigate to SignUpPage
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.green, fontSize: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
      ],
    ))));
  }
}

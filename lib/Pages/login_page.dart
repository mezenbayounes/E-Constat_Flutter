import 'package:dpc_flutter/Pages/menu.dart';
import 'package:dpc_flutter/Pages/sign_up_page.dart';
import 'package:dpc_flutter/rest/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:dpc_flutter/components/My_Box.dart';
import 'package:dpc_flutter/components/My_button.dart';
import 'package:dpc_flutter/components/My_text_filed.dart';
import 'package:dpc_flutter/components/Pwd_text_filed.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dpc_flutter/modles/user.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String? username;
  late String? password;
  final emailController = TextEditingController();

  final pwdController = TextEditingController();

  void Login() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home_Page()),
    );
  }

  final _formKey = GlobalKey<FormState>();
  var url = Uri.parse("http://192.168.1.25:3000/user/login");
  Future save() async {
    var res = await http.post(url, headers: <String, String>{
      'Context-Type': 'application/json;charSet=UTF-8'
    }, body: <String, String>{
      'email': user.email,
      'password': user.password
    });
    print(res.body);
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Home_Page()));
  }

  User user = User('ssss', 'ssss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
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
              controller: emailController,
              hintText: 'email',
              obsecureText: false,
              icon: Icons.email,
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
            My_button(onTap: Login, text: 'Login'),
            const SizedBox(height: 8),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 94),
                  child:
                      Text('New around here?', style: TextStyle(fontSize: 18)),
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

import 'package:dpc_flutter/Pages/menu.dart';
import 'package:dpc_flutter/Pages/sign_up_page.dart';
import 'package:dpc_flutter/constant/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:dpc_flutter/components/My_Box.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dpc_flutter/modles/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String? email;
  late String? password;
  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          children: [
            Form(
                key: formKey,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: 'Email',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[350]),
                            prefixIcon: Icon(Icons.email),
                          ),
                          onSaved: (String? value) {
                            email = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Email";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    //user pwd text filed
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                          obscureText: _obscureText,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: 'Password',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[350]),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          onSaved: (String? value) {
                            password = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Password";
                            } else {
                              return null;
                            }
                          }),
                    ),

                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot password  ? ',
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    // boutton Login

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 30, 65, 239),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();

                                Map<String, dynamic> reqBody = {
                                  "email": email,
                                  "password": password
                                };

                                Map<String, String> headers = {
                                  "Content-Type": "application/json"
                                };
                                print('houni');
                                try {
                                  Uri uri = Uri.http(
                                      utils.baseUrlWithoutHttp, "user/login");
                                  print(uri);
                                  print(email);
                                  print(password);
                                  http
                                      .post(uri,
                                          body: json.encode(reqBody),
                                          headers: headers)
                                      .then((http.Response response) async {
                                    if (response.statusCode == 200) {
                                      Map<String, dynamic> result =
                                          json.decode(response.body);
                                      //SHARED PREFS
                                      /*
                                     _prefs.then(
                                          (value) {
                                            value.setDouble(
                                                "balance",
                                                double.parse(
                                                    result["balance"].toString()));
                      
                                            value.setString(
                                                "username", (result["username"]));
                      
                                            value.setString("_id", (result["_id"]));
                                          },
                                        );*/

                                      print('passssssssssssssss');
                                      Navigator.pushReplacementNamed(
                                          context, "/menu");
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              title: Text("Error"),
                                              content: Text(
                                                  "Email or Password are incorrect !"),
                                            );
                                          });
                                    }
                                  });
                                } catch (error) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const AlertDialog(
                                        title: Text("Error"),
                                        content: Text(
                                            "An error occurred while making the request."),
                                      );
                                    },
                                  );
                                }
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 30, 65, 239),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))),
                      ),
                    ),

                    SizedBox(height: 8),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 94),
                          child: Text('New around here?',
                              style: TextStyle(fontSize: 18)),
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
                )),
          ],
        ))));
  }
}

import 'package:dpc_flutter/Pages/Home_Page.dart';
import 'package:dpc_flutter/Pages/menu.dart';
import 'package:dpc_flutter/Pages/sign_up_page.dart';
import 'package:dpc_flutter/constant/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:dpc_flutter/components/My_Box.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late String? currentPassword;
  late String? newPassword;
  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();

  String token = "";
  String email = "mezenbay@gmail.com";

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString('token') ?? '');
      //email = (prefs.getString('email') ?? '');
    });
  }

  @override
  void initState() {
//////////////
    super.initState();
    _loadCounter();
  }

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
                    //Logo
                    Image.asset('lib/images/privacy_policy_rafiki.png'),

                    // text welcome
                    Text(
                      'Change Your Password',
                      style: TextStyle(color: Colors.grey[800], fontSize: 26),
                    ),
                    const SizedBox(height: 50),
                    //user name text filed
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
                            labelText: 'Current Password',
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
                            currentPassword = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your Current Password";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    //new password
                    //
                    const SizedBox(height: 20),
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
                            labelText: 'New Password',
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
                            newPassword = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your New Password";
                            } else {
                              return null;
                            }
                          }),
                    ),

                    const SizedBox(height: 50),

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
                                  "currentPassword": currentPassword,
                                  "newPassword": newPassword,
                                };

                                Map<String, String> headers = {
                                  "Authorization": "Bearer $token",
                                  "Content-Type": "application/json"
                                };
                                print('houni');
                                try {
                                  Uri uri = Uri.http(utils.baseUrlWithoutHttp,
                                      "users/users/$email/password");

                                  http
                                      .put(
                                    uri,
                                    body: json.encode(reqBody),
                                    headers: headers,
                                  )
                                      .then((http.Response response) async {
                                    if (response.statusCode == 200) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            elevation: 0.0,
                                            backgroundColor: Colors.transparent,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child:const Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Text(
                                                      "Success",
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 12.0),
                                                    child: Text(
                                                      "Password Changed successfully",
                                                      style: TextStyle(
                                                          fontSize: 18.0),
                                                    ),
                                                  ),
                                                  SizedBox(height: 16.0),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Menu(index:3)),
                                        );
                                      });
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return const AlertDialog(
                                              title: Text("Error"),
                                              content: Text("Password incorrect"),
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
                                    "Done ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))),
                      ),
                    ),
                  ],
                )),
          ],
        ))));
  }
}

import 'package:dpc_flutter/Pages/login_page.dart';
import 'package:dpc_flutter/Pages/menu.dart';
import 'package:dpc_flutter/Pages/sign_up_page.dart';
import 'package:dpc_flutter/constant/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:dpc_flutter/components/My_Box.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dpc_flutter/modles/Car.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late String? email;

  final formKey = GlobalKey<FormState>();

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
                    const SizedBox(height: 20),
                    //Logo
                    Image.asset('lib/images/forgot_password.png'),

                    // text welcome
                    Text(
                      'Please enter your Email ',
                      style: TextStyle(color: Colors.grey[800], fontSize: 26),
                    ),
                    const SizedBox(height: 50),
                    //user name text filed
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
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
                    const SizedBox(height: 100),

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

                                Map<String, String> headers = {
                                  "Content-Type": "application/json"
                                };
                                print('houni');
                                try {
                                  showDialog(
                                    context: context,
                                    barrierDismissible:
                                        false, // Prevent dismissing the dialog by tapping outside
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
                                          child: const Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Text(
                                                  "Sending Email",
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child:
                                                    CircularProgressIndicator(), // Loading icon
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );

// Continue with your code for sending the email
                                  Uri uri = Uri.http(utils.baseUrlWithoutHttp,
                                      "/users/$email/forgot");
                                  http
                                      .put(uri, headers: headers)
                                      .then((http.Response response) async {
                                    Navigator.pop(
                                        context); // Dismiss the loading dialog

                                    // Handle the response based on the status code
                                    if (response.statusCode == 200) {
                                      // Show success dialog
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
                                              child: const Column(
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
                                                      "Password sent successfully",
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
                                              builder: (context) => LoginPage()),
                                        );
                                      });
                                    } else {
                                      // Show error dialog
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
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                             Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Text(
                                                "Error",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ),
                                             Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.0),
                                              child: Text(
                                                "Try Again",
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                              ),
                                            ),
                                            SizedBox(height: 16.0),
                                          
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                                    }
                                  });
                                } catch (error) {
                                   showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 0.0,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child:const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                         Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            "Error",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                        ),
                                         Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Text(
                                            "An error occurred while making the request",
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                       
                                      ],
                                    ),
                                  ),
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
                                    "Send ",
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

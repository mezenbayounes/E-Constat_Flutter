import 'dart:convert';

import 'package:dpc_flutter/Pages/verify.dart';
import 'package:flutter/material.dart';
import 'package:dpc_flutter/constant/utils.dart' as utils;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'login_page.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String? firstname;
  late String? lastname;
  late String? email;
  late String? password;
  late String? adress;
  late String? driverlicence;
  late String? delevredOn;
  late int? number;
  TextEditingController _date = TextEditingController();
  DateTime? dateDelevredOn;
  String? datecarte;
  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();

  void Sing_Up() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              Image.asset('lib/images/mobile_login_amico.png'),

              /////////////////textfiled firtName
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'User Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[350]),
                      prefixIcon: Icon(Icons.person),
                    ),
                    onSaved: (String? value) {
                      firstname = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your User Name";
                      } else {
                        return null;
                      }
                    }),
              ),
              const SizedBox(height: 10),

              ///////////////////////textfiled last name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Full Name',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[350]),
                      prefixIcon: Icon(Icons.person),
                    ),
                    onSaved: (String? value) {
                      lastname = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your Full Name";
                      } else {
                        return null;
                      }
                    }),
              ),

              const SizedBox(height: 10),

              //////////////////////////textfiled email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Email',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
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
                      } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(value)) {
                        return "Please enter a valid Email";
                      } else {
                        return null;
                      }
                    }),
              ),

              const SizedBox(height: 10),

              /////////////////////////////textfiled password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                    obscureText: _obscureText,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Password',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
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

              ///////////textfiled adress
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Adress',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[350]),
                      prefixIcon: Icon(Icons.location_pin),
                    ),
                    onSaved: (String? value) {
                      adress = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your Adress";
                      } else {
                        return null;
                      }
                    }),
              ),

              const SizedBox(height: 10),
              ///////////////// textfiled driver licence
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Driver Licence',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[350]),
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    onSaved: (String? value) {
                      driverlicence = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your Driver Licence";
                      } else {
                        return null;
                      }
                    }),
              ),
              SizedBox(height: 10),
              //////////////textfiled delevredOn
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                    controller: _date,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Delevred On',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[350]),
                      prefixIcon: Icon(Icons.calendar_month_rounded),
                    ),
                    onTap: () async {
                      DateTime? pickerdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));
                      if (pickerdate != null) {
                        setState(() {
                          _date.text =
                              DateFormat('yyyy-MM-dd').format(pickerdate);
                          datecarte = pickerdate.toIso8601String();
                        });
                      }
                    },
                    onSaved: (String? value) {
                      delevredOn = datecarte;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your Driver Licence Date";
                      } else {
                        return null;
                      }
                    }),
              ),

              SizedBox(height: 10),
              //////////////::textfiled number
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Phone Number',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[350]),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    onSaved: (String? value) {
                      number = int.parse(value!);
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length != 8) {
                        return "Please enter a correct number";
                      } else {
                        return null;
                      }
                    }),
              ),

              const SizedBox(height: 30),
              /////////////////// sign up button

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
                            "username": firstname,
                            "fullName": lastname,
                            "email": email,
                            "password": password,
                            "address": adress,
                            "driverLicense": driverlicence,
                            "deliveredOn": delevredOn,
                            "number": number
                          };

                          Map<String, dynamic> reqBodyEmail = {
                            "email": email,
                          };

                          Map<String, String> headers = {
                            "Content-Type": "application/json"
                          };
                          print('houni');
                          try {
                            Uri uri = Uri.http(
                                utils.baseUrlWithoutHttp, "api/auth/register");

                            Uri uriOTP = Uri.http(utils.baseUrlWithoutHttp,
                                "users/sendotp/$email");
                            print(uriOTP);

                            http
                                .post(uri,
                                    body: json.encode(reqBody),
                                    headers: headers)
                                .then((http.Response response) async {
                              if (response.statusCode == 200) {

                                http
                                    .post(uriOTP, headers: headers)
                                    .then((http.Response response) async {
                                  if (response.statusCode == 200) {
                                    print("opt sended");
                                  } else {
                                    print("noooooooo");
                                  }
                                });
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
                                                "Success",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.0),
                                              child: Text(
                                                "User Created",
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
                                ).then((value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Verify()),
                                  );
                                });
                              } else if (response.statusCode == 400) {
                                
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
                                                "User Already Exist",
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
                              } else {
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
                              "Sign UP",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        )),
      ),
    );
  }
}

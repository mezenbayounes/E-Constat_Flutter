import 'package:dpc_flutter/Pages/Change_Password.dart';
import 'package:dpc_flutter/Pages/Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'dart:convert';

import 'package:dpc_flutter/constant/utils.dart' as utils;
import 'package:http/http.dart' as http;

class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  String token = "";
  String dataUser = "";
  String number = "";
  String userId = "";
  String username = "";
  String fullName = "";
  String address = "";
  String emailProfile = "";
  String driverLicense = "";
  String delivredOn = "";

  String? numberUpdate;
  String? usernameUpdate;
  String? fullNameUpdate;
  String? addressUpdate;
  String? emailProfileUpdate;
  String? driverLicenseUpdate;
  String? delivredOnUpdate;

  bool update = false;
  String? dateDelevredOn;
  String? datecarte;
  TextEditingController _date = TextEditingController();
  final formKey = GlobalKey<FormState>();

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      number = (prefs.getString('number') ?? '');
      username = (prefs.getString('username') ?? '');
      userId = (prefs.getString('userId') ?? '');

      fullName = (prefs.getString('fullName') ?? '');
      address = (prefs.getString('address') ?? '');
      emailProfile = (prefs.getString('emailProfile') ?? '');
      driverLicense = (prefs.getString('driverLicense') ?? '');
      delivredOn = (prefs.getString('deliveredOn') ?? '');

      token = (prefs.getString('token') ?? '');
      _date.text = delivredOn;
      final parts = token.split('.');
      if (parts.length >= 2) {
        final payload = parts[1];
        dataUser = B64urlEncRfc7515.decodeUtf8(payload);
      } else {
        // Handle the case where the token does not contain the expected number of parts.
        // You may want to set a default value or show an error message.
      }

      print(emailProfile);
    });
  }

  @override
  void initState() {
//////////////
    super.initState();
    _loadCounter();
    _date.text = delivredOn;
    print(delivredOn);
  }

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
              SizedBox(height: 20),

              Image.asset(
                'lib/images/defpdp.png',
                height: 200,
                width: 200,
              ),
              SizedBox(height: 50),

              /////////////////textfiled firtName
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                    controller: TextEditingController(text: username),
                    enabled: false,
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
                      hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      prefixIcon: Icon(Icons.person),
                    ),
                    onSaved: (String? value) {
                      usernameUpdate = value!;
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
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                    controller: TextEditingController(text: fullName),
                    enabled: update,
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
                      fullNameUpdate = value!;
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
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                    controller: TextEditingController(text: emailProfile),
                    enabled: update,
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
                      emailProfileUpdate = value!;
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

              ///////////textfiled adress
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                    controller: TextEditingController(text: address),
                    enabled: update,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Address',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[350]),
                      prefixIcon: Icon(Icons.location_pin),
                    ),
                    onSaved: (String? value) {
                      addressUpdate = value!;
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
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                    controller: TextEditingController(text: driverLicense),
                    enabled: update,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Driver License',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[350]),
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                    onSaved: (String? value) {
                      driverLicenseUpdate = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your Driver Licence";
                      } else {
                        return null;
                      }
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              //////////////textfiled delevredOn
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                    controller: _date,
                    enabled: update,
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
                      delivredOnUpdate = datecarte;
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
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextFormField(
                    controller: TextEditingController(text: number),
                    enabled: update,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Tel Number',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[350]),
                      prefixIcon: Icon(Icons.phone),
                    ),
                    onSaved: (String? value) {
                      numberUpdate = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length != 8) {
                        return "Please enter a correct number";
                      } else {
                        return null;
                      }
                    }),
              ),

              /////////////////// sign up button

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 30, 170, 2),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextButton(
                        onPressed: () {
                          print(datecarte);
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            Map<String, dynamic> reqBody = {
                              "username": usernameUpdate,
                              "fullName": fullNameUpdate,
                              "email": emailProfileUpdate,
                              "address": addressUpdate,
                              "deliveredOn": delivredOnUpdate,
                              "driverLicense": driverLicenseUpdate,
                              "number": number
                            };
                            //print(delivredOnUpdate);
                            Map<String, String> headers = {
                              "Authorization": "Bearer $token",
                              "Content-Type": "application/json"
                            };
//////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////
                            try {
                              Uri uri = Uri.http(
                                  utils.baseUrlWithoutHttp, "users/$userId");

                              http
                                  .put(uri,
                                      body: json.encode(reqBody),
                                      headers: headers)
                                  .then((http.Response response) async {
                                if (response.statusCode == 200) {
                                  setState(() {
                                    if (update == false) {
                                      update = true;
                                    } else {
                                      update = false;
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
                                                  "User updated",
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
                                  update = false;
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
                                                      fontWeight:
                                                          FontWeight.bold,
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
                          ////////////////////////////////////////////////
                          /////////////////////////////////////////////
                          ///////////////////////////////////////
                        },
                        child: Container(
                          width: 150, // Adjust the width as needed
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(100, 30, 170,
                                2), // Reduced opacity to make it semi-transparent
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1, // Width of the vertical divider
                    color: Colors.grey, // Color of the vertical divider
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 30, 65, 239),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (update == false) {
                              update = true;
                            } else {
                              update = false;
                            }
                          });
                        },
                        child: Container(
                          width: 150, // Adjust the width as needed
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 30, 65, 239),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Center(
                            child: Text(
                              "Update",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                ), // Navigate to SignUpPage
                child: const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Change Password 🔒 ',
                    style: TextStyle(
                        color: Color.fromARGB(255, 133, 128, 128),
                        fontSize: 16),
                  ),
                ),
              ),

              SizedBox(height: 60),
            ],
          ),
        )),
      ),
    );
  }
}

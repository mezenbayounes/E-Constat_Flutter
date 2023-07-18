import 'package:dpc_flutter/Pages/Forgot_Password.dart';
import 'package:dpc_flutter/Pages/menu.dart';
import 'package:dpc_flutter/Pages/sign_up_page.dart';
import 'package:dpc_flutter/Pages/verify.dart';
import 'package:dpc_flutter/Pages/verifyFromLogin.dart';
import 'package:dpc_flutter/constant/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:dpc_flutter/components/My_Box.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dpc_flutter/modles/Car.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String token = "";

  String dataUser = "";

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString('token') ?? '');
      final parts = token.split('.');
      final payload = parts[1];
      final decodedPayload = B64urlEncRfc7515.decodeUtf8(payload);
      final payloadMap = json.decode(decodedPayload);
      dataUser = payloadMap['sub'];
    });
  }

  @override
  void initState() {
//////////////
    super.initState();
    _loadCounter();
  }

  //////////////////////////////////////////////////
  late String? email;
  late String? password;

  late String tokenToString = "a";
  late int userId;

  late String username = "a";
  late String fullName = "a";
  late String address = "a";
  late String driverLicense = "a";
  //late DateTime delevredOn;
  late int number;
  late String emailProfile = "a";

  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
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
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: 'User Name',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[350]),
                            prefixIcon: Icon(Icons.person),
                          ),
                          onSaved: (String? value) {
                            email = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your user Name";
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
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword()),
                            ), // Navigate to SignUpPage
                            child: const Text(
                              'Forgot password  ? ',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 133, 128, 128),
                                  fontSize: 16),
                            ),
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
                                print('Sub : $dataUser');
                                Map<String, dynamic> reqBody = {
                                  "username": email,
                                  "password": password
                                };

                                Map<String, String> headers = {
                                  "Content-Type": "application/json"
                                };
                                print('houni');
                                try {
                                  Uri uri = Uri.http(utils.baseUrlWithoutHttp,
                                      "api/auth/login");

                                  http
                                      .post(uri,
                                          body: json.encode(reqBody),
                                          headers: headers)
                                      .then((http.Response response) async {
                                    if (response.statusCode == 200) {
                                      Map<String, dynamic> result =
                                          json.decode(response.body);

                                      //SHARED PREFS
                                      tokenToString = result["accessToken"];
                                      final parts = tokenToString.split('.');
                                      final payload = parts[1];
                                      final decodedPayload =
                                          B64urlEncRfc7515.decodeUtf8(payload);
                                      final payloadMap =
                                          json.decode(decodedPayload);
                                      dataUser = payloadMap['sub'];

                                      saveData(
                                          "token", tokenToString.toString());
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      String? value = prefs.getString("token");
                                      print('token login $value');
                                      print('passssssssssssssss');
                                      Navigator.pushReplacementNamed(
                                          context, "/menu");
//////////////////////////////////
                                      Map<String, String> headersPofile = {
                                        "Authorization": "Bearer $value",
                                        "Content-Type": "application/json"
                                      };
                                      print('Sub2 : $dataUser');
                                      Uri uriProfile = Uri.http(
                                          utils.baseUrlWithoutHttp,
                                          "users/getbyusername/$dataUser");
                                      http
                                          .get(uriProfile,
                                              headers: headersPofile)
                                          .then((http.Response response) async {
                                        if (response.statusCode == 200) {
                                          Map<String, dynamic> resultProfile =
                                              json.decode(response.body);

                                          userId = resultProfile["userId"];
                                          username = resultProfile["username"];
                                          fullName = resultProfile["fullName"];
                                          address = resultProfile["address"];
                                          driverLicense =
                                              resultProfile["driverLicense"];
                                          number = resultProfile["number"];
                                          emailProfile = resultProfile["email"];
                                          //delevredOn = resultProfile["deliveredOn"];
                                          saveData("token", tokenToString.toString());
                                          saveData("userId", userId.toString());
                                          saveData(
                                              "username", username.toString());
                                          saveData(
                                              "fullName", fullName.toString());
                                          saveData(
                                              "address", address.toString());
                                          saveData("driverLicense",
                                              driverLicense.toString());
                                          saveData("number", number.toString());
                                          saveData("emailProfile",
                                              emailProfile.toString());
                                          //saveData("deliveredOn",delevredOn.toString());
                                          SharedPreferences prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          String? value =
                                              prefs.getString("userId");
                                          print(value);
                                        } else {
                                          print("ereeeeeeeeeeeeeeeeeer");
                                        }
                                        ;
                                      });
                                    } else if (response.statusCode == 401) {
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
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Text(
                                                      "Error",
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16.0),
                                                    child: Text(
                                                      "User not verified ",
                                                      style: TextStyle(
                                                          fontSize: 16.0),
                                                    ),
                                                  ),
                                                  SizedBox(height: 16.0),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      primary: Colors.red,
                                                    ),
                                                    child: const Text(
                                                      "OK",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const VerifyFromLogin()),
                                        );
                                      });
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
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(16.0),
                                                    child: Text(
                                                      "Error",
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 16.0),
                                                    child: Text(
                                                      "Try Again ",
                                                      style: TextStyle(
                                                          fontSize: 18.0),
                                                    ),
                                                  ),
                                                  SizedBox(height: 16.0),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      primary: Colors.red,
                                                    ),
                                                    child: const Text(
                                                      "OK",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
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
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Text(
                                                  "Error",
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                                child: Text(
                                                  "An error occurred while making the request.",
                                                  style:
                                                      TextStyle(fontSize: 18.0),
                                                ),
                                              ),
                                              SizedBox(height: 16.0),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  primary: Colors.red,
                                                ),
                                                child: const Text(
                                                  "OK",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                ;
//////////////////////////////////////////
                                ///

//////////////////////
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

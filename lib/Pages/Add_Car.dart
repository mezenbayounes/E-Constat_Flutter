import 'package:dpc_flutter/Pages/My_carsPage.dart';
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

class AddCar extends StatefulWidget {
  const AddCar({super.key});

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  late String? fiscalPower;
  late String? serialNumber;
  late String? matricule1;
  late String? matricule2;
  late String? matricule;
  String token = "";
  String userId = "";

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString('token') ?? '');
      userId = (prefs.getString('userId') ?? '');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  final formKey = GlobalKey<FormState>();
  List<String> listBrand = <String>[
    "Audi",
    "Bentley",
    "BMW",
    "Brabus",
    "Chery",
    "Chevrolet",
    "Chrysler",
    "Citroen",
    "Corvette",
    "Dacia",
    "Fiat",
    "Ford",
    "Geely",
    "Genesis",
    "GMC",
    "Haval",
    "Honda",
    "Hummer",
    "Hyundai",
    "Infiniti",
    "Isuzu",
    "Iveco",
    "Jaguar",
    "Jeep",
    "Kia",
    "Lamborghini",
    "LandRover",
    "Lexus",
    "Mahindra",
    "MAN",
    "Maserati",
    "Maybach",
    "Mazda",
    "Mercedes",
    "MG",
    "Mini",
    "Mitsubishi",
    "Nissan",
    "Opel",
    "Peugeot",
    "Porsche",
    "Renault",
    "SEAT",
    "Skoda",
    "SsangYong",
    "Suzuki",
    "Triumph",
    "Volkswagen"
  ];
  List<String> listType = <String>[
    "Essence",
    "Diesel",
  ];
  String dropdownValueBrand = 'Audi';
  String dropdownValueType = 'Essence';

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
                    const SizedBox(height: 60),
                    const Center(
                        child: Text(
                      "Choose Your Car Brand",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
////////////////// Brand
                    DropdownButton<String>(
                      value: dropdownValueBrand,
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: const Color.fromARGB(255, 6, 142, 205),
                      ),
                      elevation: 8,
                      style: const TextStyle(
                          color: const Color.fromARGB(255, 6, 142, 205),
                          fontSize: 25),
                      underline: Container(
                        height: 2,
                        color: const Color.fromARGB(255, 6, 142, 205),
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValueBrand = value!;
                        });
                      },
                      items: listBrand
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 25),
                          ),
                        );
                      }).toList(),
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40),
                      child: Divider(
                        color: Color.fromARGB(222, 249, 170, 34),
                        thickness: 2,
                      ),
                    ),
                    ////////////////////
                    const SizedBox(height: 20),
                    const Center(
                        child: Text(
                      "Choose Your Car Type",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),

                    ////////////////// Type
                    DropdownButton<String>(
                      value: dropdownValueType,
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: const Color.fromARGB(255, 6, 142, 205),
                      ),
                      elevation: 16,
                      style: const TextStyle(
                          color: const Color.fromARGB(255, 6, 142, 205),
                          fontSize: 25),
                      underline: Container(
                        height: 2,
                        color: const Color.fromARGB(255, 6, 142, 205),
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValueType = value!;
                        });
                      },
                      items: listType
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 25),
                          ),
                        );
                      }).toList(),
                    ),

                    const Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40),
                      child: Divider(
                        color: Color.fromARGB(222, 249, 170, 34),
                        thickness: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ////////////////////
                    //fiscal Power filed
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: 'Fiscal Power',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[350]),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: ImageIcon(
                                AssetImage("lib/images/fiscalPower.png"),
                                size: 50,
                              ),
                            ),
                          ),
                          onSaved: (String? value) {
                            fiscalPower = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Your Car Fiscal Power";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    const SizedBox(height: 20),

                    const Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40),
                      child: Divider(
                        color: Color.fromARGB(222, 249, 170, 34),
                        thickness: 2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(15.0)),
                            labelText: 'Serial Number',
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[350]),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.badge_outlined,
                                size: 50,
                              ),
                            ),
                          ),
                          onSaved: (String? value) {
                            serialNumber = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Your Car Serial Number";
                            } else {
                              return null;
                            }
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40),
                      child: Divider(
                        color: Color.fromARGB(222, 249, 170, 34),
                        thickness: 2,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Center(
                        child: Text(
                      "Matricule",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onSaved: (String? value) {
                                matricule1 = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "!!!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              enabled: false,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                hintText: "TUN",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 0, right: 25.0),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.black,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.zero,
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              onSaved: (String? value) {
                                matricule2 = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "!!!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 100),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              matricule = "$matricule1 TUN $matricule2";
                              Map<String, dynamic> reqBody = {
                                "carBrand": dropdownValueBrand,
                                "type": dropdownValueType,
                                "fiscalPower": fiscalPower,
                                "numSerie": serialNumber,
                                "numImmatriculation": matricule,
                                "carImage": "carimage"
                              };

                              Map<String, String> headers = {
                                "Authorization": "Bearer $token",
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
                                Uri uri = Uri.http(
                                    utils.baseUrlWithoutHttp, "/car/$userId");
                                http
                                    .post(uri,
                                        body: json.encode(reqBody),
                                        headers: headers)
                                    .then((http.Response response) async {
                                  Navigator.pop(
                                      context); // Dismiss the loading dialog

                                  // Handle the response based on the status code
                                  if (response.statusCode == 202) {
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
                                                  padding: EdgeInsets.all(16.0),
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
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                                  child: Text(
                                                    "Car Added",
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
                                        builder: (context) => Menu(index:1)),
                                  );
                                    });
                                  } else if (response.statusCode == 409) {
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.0),
                                                  child: Text(
                                                    "Car Already Exist",
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
                                    );
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
                            }
                          },
                          icon: const Icon(
                            Icons.add_circle_outline_sharp,
                            color: Color.fromARGB(255, 6, 142, 205),
                            size: 80,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ))));
  }
}

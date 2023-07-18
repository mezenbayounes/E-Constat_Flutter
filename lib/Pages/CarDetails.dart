import 'dart:convert';
import 'package:dpc_flutter/Pages/menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/CarItem.dart';
import '../constant/utils.dart' as utils;
import '../modles/Car.dart';
import '../modles/Insurance.dart';

class CarDetails extends StatefulWidget {
  final Car car;
  const CarDetails({super.key, required this.car});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  String token = "";
  String insuranceName = "";
  String insuranceId = "";

  String userId = "";
  String dataUser = "";
  late String? numContrat;
  late String? agency;
  TextEditingController _dateFrom = TextEditingController();
  String? validityFrom;
  String? dateFrom;
  TextEditingController _dateTo = TextEditingController();
  String? validityTo;
  String? dateTo;

  final formKey = GlobalKey<FormState>();

  List<String> listInsurance = <String>[
    "hayet",
    "ami",
    "star",
    "comar",
  ];
  String dropdownValueInsurance = 'hayet';

  late Future<bool> insuranceFetched;
  Future<void> refreshData() async {
    await fetchInsuranceFromServer();
  }

  Future<bool> fetchInsuranceFromServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      userId = (prefs.getString('userId') ?? '');
      token = (prefs.getString('token') ?? '');

      final parts = token.split('.');
      if (parts.length >= 2) {
        final payload = parts[1];
        dataUser = B64urlEncRfc7515.decodeUtf8(payload);
      } else {
        // Handle the case where the token does not contain the expected number of parts.
        // You may want to set a default value or show an error message.
      }
    });
    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };
    Uri uriGetInsurance =
        Uri.http(utils.baseUrlWithoutHttp, "/car/get/${widget.car.numSerie}");
    http.Response responseInsurance =
        await http.get(uriGetInsurance, headers: headers);
    Map<String, dynamic> resultInsurance = json.decode(responseInsurance.body);
    insuranceName = resultInsurance["name"];
    print(' testtttttttt $insuranceName');

    /* Uri uri = Uri.http(utils.baseUrlWithoutHttp, "/insurance/$insuranceId");

    http.Response response = await http.get(uri, headers: headers);
    Map<String, dynamic> result = json.decode(response.body);
    insuranceName = result["name"];
    print(insuranceName);*/

    return true;
  }

  @override
  void initState() {
    super.initState();
    insuranceFetched = fetchInsuranceFromServer();
  }
  //////////////////////////////////////////////////////
  ///////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
            child: RefreshIndicator(
          onRefresh: refreshData,
          child: FutureBuilder<bool>(
              future: insuranceFetched, // Use the Future<bool> here
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // If data is still loading, you can show a loading indicator.
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError) {
                    ////////////////////////////////////////////////////////////////////////////////////////
                    ///////////////////////////////// en cas pas d'assurance
                    return Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 268,
                              top: 40,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 6, 142, 205),
                                border: Border.all(
                                  color: Color.fromARGB(222, 249, 170, 34),
                                  width: 2,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(50.0),
                                  bottomRight: Radius.circular(50.0),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Car Details',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 0, right: 0),
                            child: Divider(
                              color: Color.fromARGB(255, 6, 142, 205),
                              thickness: 3,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Please fill the missing Information ⚠️',
                            style: TextStyle(color: Colors.red, fontSize: 23),
                          ),
                          SizedBox(height: 30),
                          ////////////////// Brand
                          DropdownButton<String>(
                            value: dropdownValueInsurance,
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
                                dropdownValueInsurance = value!;
                              });
                            },
                            items: listInsurance
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
                          const SizedBox(height: 10),
                          ///////////////// textfiled driver licence
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextFormField(
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Num Contrat',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                  prefixIcon: Icon(Icons.badge_outlined),
                                ),
                                onSaved: (String? value) {
                                  numContrat = value!;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your Contrat Number";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextFormField(
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Agency',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                  prefixIcon: Icon(Icons.shield_outlined),
                                ),
                                onSaved: (String? value) {
                                  agency = value!;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your Contrat Number";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextFormField(
                                controller: _dateFrom,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Validity From',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                  prefixIcon:
                                      Icon(Icons.calendar_month_rounded),
                                ),
                                onTap: () async {
                                  DateTime? pickerdate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101));
                                  if (pickerdate != null) {
                                    setState(() {
                                      _dateFrom.text = DateFormat('yyyy-MM-dd')
                                          .format(pickerdate);
                                      dateFrom = pickerdate.toIso8601String();
                                    });
                                  }
                                },
                                onSaved: (String? value) {
                                  validityFrom = dateFrom;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your Driver Licence Validity Date";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.0),
                            child: TextFormField(
                                controller: _dateTo,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  labelText: 'Validity To',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintStyle: TextStyle(color: Colors.grey[350]),
                                  prefixIcon:
                                      Icon(Icons.calendar_month_rounded),
                                ),
                                onTap: () async {
                                  DateTime? pickerdate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101));
                                  if (pickerdate != null) {
                                    setState(() {
                                      _dateTo.text = DateFormat('yyyy-MM-dd')
                                          .format(pickerdate);
                                      dateTo = pickerdate.toIso8601String();
                                    });
                                  }
                                },
                                onSaved: (String? value) {
                                  validityTo = dateTo;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your Driver Licence Validity Date";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 60),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 30, 170, 2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();

                                      Map<String, dynamic> reqBody = {
                                        "agency": agency,
                                        "carId": widget.car.carId,
                                        "name": dropdownValueInsurance,
                                        "numContrat": numContrat,
                                        "validityFrom": validityFrom,
                                        "validityTo": validityTo,
                                      };

                                      Map<String, String> headers = {
                                        "Content-Type": "application/json",
                                        "Authorization": "Bearer $token"
                                      };
                                      print('houni  car details');
                                      print(token);

                                      try {
                                        Uri uri = Uri.http(
                                            utils.baseUrlWithoutHttp,
                                            "insurance/addNewInsurance");

                                        http
                                            .post(uri,
                                                body: json.encode(reqBody),
                                                headers: headers)
                                            .then(
                                                (http.Response response) async {
                                          if (response.statusCode == 200) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  elevation: 0.0,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: const Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16.0),
                                                          child: Text(
                                                            "Success",
                                                            style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12.0),
                                                          child: Text(
                                                            "Insurance Added",
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
                                                    builder: (context) =>
                                                        const Menu(
                                                          index: 2,
                                                        )),
                                              );
                                            });
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  elevation: 0.0,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: const Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  16.0),
                                                          child: Text(
                                                            "Error",
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12.0),
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
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: const Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(16.0),
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
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 12.0),
                                                      child: Text(
                                                        "An error occurred while making the request",
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
                                    }
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 30, 170, 2),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Add Insurance",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))),
                            ),
                          ),

                          SizedBox(
                            height: 20,
                          ),

                          const Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: Divider(
                              color: const Color.fromARGB(255, 6, 142, 205),
                              thickness: 3,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: Divider(
                              color: Color.fromARGB(222, 249, 170, 34),
                              thickness: 3,
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              "lib/images/${widget.car.carBrand}.png",
                              height: 200,
                              width: 300,
                            ),
                          ),
                          const Padding(
                            padding: const EdgeInsets.only(left: 0.0, right: 0),
                            child: Divider(
                              color: Color.fromARGB(222, 249, 170, 34),
                              thickness: 3,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Brand",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color.fromARGB(
                                              255, 109, 108, 108)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 150.0),
                                      child: Text(
                                        widget.car.carBrand!,
                                        style: const TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 0),
                                  child: Divider(
                                    color: Color.fromARGB(222, 188, 188, 188),
                                    thickness: 2,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Type  ",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color.fromARGB(
                                              255, 109, 108, 108)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 150.0),
                                      child: Text(
                                        widget.car.type!,
                                        style: const TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 0),
                                  child: Divider(
                                    color: Color.fromARGB(222, 188, 188, 188),
                                    thickness: 2,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "N°Serie  ",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color.fromARGB(
                                              255, 109, 108, 108)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 120.0),
                                      child: Text(
                                        widget.car.numSerie!,
                                        style: const TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 0),
                                  child: Divider(
                                    color: Color.fromARGB(222, 188, 188, 188),
                                    thickness: 2,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Fiscal Power ",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color.fromARGB(
                                              255, 109, 108, 108)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 60.0),
                                      child: Text(
                                        ' ${widget.car.fiscalPower!}',
                                        style: const TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 0),
                                  child: Divider(
                                    color: Color.fromARGB(222, 188, 188, 188),
                                    thickness: 2,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Matricule  ",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Color.fromARGB(
                                              255, 109, 108, 108)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 100.0),
                                      child: Text(
                                        widget.car.numImmatriculation!,
                                        style: const TextStyle(
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 0),
                                  child: Divider(
                                    color: Color.fromARGB(222, 188, 188, 188),
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    );
                  }
                  // Data has been fetched successfully, show the widget.
                  ////////////////////////////////////////////////////////////////////////////////////////
                  ///////////////////////////////// en cas assurance Exist
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 268,
                          top: 40,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 6, 142, 205),
                            border: Border.all(
                              color: Color.fromARGB(222, 249, 170, 34),
                              width: 2,
                            ),
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Car Details',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Visibility(
                            visible: true,
                            maintainAnimation: true,
                            maintainState: true,
                            child: Column(
                              children: [
                                const Padding(
                                  padding:
                                      const EdgeInsets.only(left: 0, right: 0),
                                  child: Divider(
                                    color:
                                        const Color.fromARGB(255, 6, 142, 205),
                                    thickness: 3,
                                  ),
                                ),
                                Center(
                                  child: Image.asset(
                                    "lib/images/$insuranceName.png",
                                    height: 120,
                                    width: 300,
                                  ),
                                ),
                                const Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 0),
                                  child: Divider(
                                    color:
                                        const Color.fromARGB(255, 6, 142, 205),
                                    thickness: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Divider(
                          color: Color.fromARGB(222, 249, 170, 34),
                          thickness: 3,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          "lib/images/${widget.car.carBrand}.png",
                          height: 200,
                          width: 300,
                        ),
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(left: 0.0, right: 0),
                        child: Divider(
                          color: Color.fromARGB(222, 249, 170, 34),
                          thickness: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Brand",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color:
                                          Color.fromARGB(255, 109, 108, 108)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 150.0),
                                  child: Text(
                                    widget.car.carBrand!,
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Divider(
                                color: Color.fromARGB(222, 188, 188, 188),
                                thickness: 2,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Type  ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color:
                                          Color.fromARGB(255, 109, 108, 108)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 150.0),
                                  child: Text(
                                    widget.car.type!,
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Divider(
                                color: Color.fromARGB(222, 188, 188, 188),
                                thickness: 2,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "N°Serie  ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color:
                                          Color.fromARGB(255, 109, 108, 108)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: Text(
                                    widget.car.numSerie!,
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Divider(
                                color: Color.fromARGB(222, 188, 188, 188),
                                thickness: 2,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Fiscal Power ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color:
                                          Color.fromARGB(255, 109, 108, 108)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 60.0),
                                  child: Text(
                                    ' ${widget.car.fiscalPower!}',
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Divider(
                                color: Color.fromARGB(222, 188, 188, 188),
                                thickness: 2,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Matricule  ",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color:
                                          Color.fromARGB(255, 109, 108, 108)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: Text(
                                    widget.car.numImmatriculation!,
                                    style: const TextStyle(
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Divider(
                                color: Color.fromARGB(222, 188, 188, 188),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                ;
              }),
        )));
  }
}

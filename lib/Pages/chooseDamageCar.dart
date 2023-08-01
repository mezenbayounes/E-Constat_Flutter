import 'dart:async';
import 'dart:convert';
import 'package:dpc_flutter/Pages/CarItemChoose.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/CarItem.dart';
import '../constant/utils.dart' as utils;
import '../modles/Car.dart';

class ChooseDamageCar extends StatefulWidget {
  const ChooseDamageCar({Key? key}) : super(key: key);

  @override
  State<ChooseDamageCar> createState() => _ChooseDamageCarState();
}

class _ChooseDamageCarState extends State<ChooseDamageCar> {
  String token = "";
  String userId = "";
  String dataUser = "";
  List<Car> cars = [];
  late Timer timer;
  late Future<bool> carFetched;

  Future<bool> fetchCarFromServer() async {
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
    try {
      print("Token: $token");
      print("USERID: $userId");

      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      Uri uri = Uri.http(utils.baseUrlWithoutHttp, "/users/getCars/$userId");

      http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> carsRetrieved = json.decode(response.body);

        setState(() {
          cars = carsRetrieved
              .map((car) => Car(
                    carId: car["carId"],
                    carBrand: car["carBrand"],
                    type: car["type"],
                    numSerie: car["numSerie"],
                    numImmatriculation: car["numImmatriculation"],
                    fiscalPower: int.parse(car["fiscalPower"].toString()),
                  ))
              .toList();
        });

        return true;
      } else {
        // Handle non-200 response status code
        print('Error: ${response.statusCode}');

        return false;
      }
    } catch (error) {
      // Handle any exceptions that occur during the HTTP request or JSON decoding
      print('Error: $error');

      return false;
    }
  }

  Future<void> refreshData() async {
    await fetchCarFromServer();
  }

  @override
  void initState() {
    super.initState();

    carFetched = fetchCarFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: FutureBuilder<bool>(
          future: carFetched,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Container(
                      width: 360,
                      height: 100,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 235, 235, 235),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.white,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          const Center(
                            child: Text(
                              'Choose The Damaged Car',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: const Color.fromARGB(255, 6, 142, 205),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cars.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: CarItemChoose(
                            car: cars[index],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

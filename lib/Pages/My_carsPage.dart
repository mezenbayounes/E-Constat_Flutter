import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/CarItem.dart';
import '../constant/utils.dart' as utils;
import '../modles/Car.dart';

class MyCars extends StatefulWidget {
  const MyCars({Key? key}) : super(key: key);

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  String token = "";
  String dataUser = "";
  List<Car> cars = [];
  late Future<bool> carFetched;

  Future<bool> fetchCarFromServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString('token') ?? '');
      final parts = token.split('.');
      final payload = parts[1];
      final decodedPayload = B64urlEncRfc7515.decodeUtf8(payload);
      final payloadMap = json.decode(decodedPayload);
      dataUser = payloadMap['sub'];
    });
    try {
      print("mezeenn $token");
      Map<String, String> headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      };
      Uri uri = Uri.http(utils.baseUrlWithoutHttp, "/car/get");

      http.Response response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> carsRetrieved = json.decode(response.body);

        for (var car in carsRetrieved) {
          cars.add(
            Car(
              carBrand: car["carBrand"],
              type: car["type"],
              numSerie: car["numSerie"],
              numImmatriculation: car["numImmatriculation"],
              fiscalPower: int.parse(car["fiscalPower"].toString()),
            ),
          );
          print("aaaaaaaaaaaaaaaaaaaa");
        }

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

  @override
  void initState() {
    super.initState();

    carFetched = fetchCarFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: FutureBuilder<bool>(
        future: carFetched,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 250, top: 40),
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
                        ' Your Cars    ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 350,
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
                            'Manage Your Cars ',
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
                        child: CarItem(
                          car: cars[index],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 100.0, left: 60.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add_circle_outline_sharp,
                      color: Color.fromARGB(255, 6, 142, 205),
                      size: 80,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/addCar');
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
    );
  }
}

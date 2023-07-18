import 'package:dpc_flutter/Pages/CarDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dpc_flutter/constant/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modles/Car.dart';

class CarItem extends StatefulWidget {
  final Car car;
  const CarItem({Key? key, required this.car}) : super(key: key);

  @override
  State<CarItem> createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  String? token;

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      token = (prefs.getString('token') ?? '');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _deleteCar() {
    int? carid = widget.car.carId;

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    try {
      Uri uri = Uri.http(utils.baseUrlWithoutHttp, "/car/removeCar/$carid");

      http.post(uri, headers: headers).then((http.Response response) async {
        if (response.statusCode == 200) {
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
                          "Success",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Car deleted",
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
        } else {
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
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "Try Again",
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
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
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

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(), // Use UniqueKey for each item to maintain uniqueness
      onDismissed: (_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirmation",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              content: const Text(
                "Are you sure you want to delete the Car?",
                style: TextStyle(fontSize: 18),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Cancel",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue)),
                ),
                TextButton(
                  onPressed: () {
                    // Perform the delete operation
                    _deleteCar();
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text("Delete",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                ),
              ],
            );
          },
        );
      },
      background: Container(
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
      ),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarDetails(car: widget.car),
          ),
        ),
        child: Card(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                  color: Color.fromARGB(222, 249, 170, 34), width: 2),
              color: Colors.grey[200],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      "lib/images/${widget.car.carBrand}.png",
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        Center(
                          child: Text(
                            widget.car.numImmatriculation!,
                            style: const TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

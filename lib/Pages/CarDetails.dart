import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pages/CarItem.dart';
import '../constant/utils.dart' as utils;
import '../modles/Car.dart';

class CarDetails extends StatefulWidget {
  final Car car;
  const CarDetails({super.key, required this.car});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
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
            Center(
              child: Image.asset(
                "lib/images/star.png",
                height: 110,
                width: 300,
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0),
              child: Divider(
                color: const Color.fromARGB(255, 6, 142, 205),
                thickness: 3,
              ),
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
                            color: Color.fromARGB(255, 109, 108, 108)),
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
                            color: Color.fromARGB(255, 109, 108, 108)),
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
                            color: Color.fromARGB(255, 109, 108, 108)),
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
                            color: Color.fromARGB(255, 109, 108, 108)),
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
                            color: Color.fromARGB(255, 109, 108, 108)),
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
        ),
      ),
    );
  }
}

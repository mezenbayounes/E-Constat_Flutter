import 'package:dpc_flutter/Pages/CarDetails.dart';
import 'package:dpc_flutter/Pages/ConfirmeChooseCar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dpc_flutter/constant/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../modles/Car.dart';

class CarItemChoose extends StatefulWidget {
  final Car car;
  const CarItemChoose({Key? key, required this.car}) : super(key: key);

  @override
  State<CarItemChoose> createState() => _CarItemChooseState();
}

class _CarItemChooseState extends State<CarItemChoose> {
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

 
  @override
  Widget build(BuildContext context) {
    return 
      InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmeChooseCar(car: widget.car),
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
      
    );
  }
}

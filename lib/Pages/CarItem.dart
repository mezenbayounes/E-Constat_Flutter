import 'package:dpc_flutter/Pages/CarDetails.dart';
import 'package:dpc_flutter/Pages/Settings_Page.dart';
import 'package:flutter/material.dart';

import '../modles/Car.dart';

class CarItem extends StatelessWidget {
  final Car car;
  const CarItem({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CarDetails(car: car),
          //builder: (context) => SettingsPage(),
        ),
      ),
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border:
                Border.all(color: Color.fromARGB(222, 249, 170, 34), width: 2),
            color: Colors.grey[200],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "lib/images/${car.carBrand}.png",
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
                          car.numImmatriculation!,
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

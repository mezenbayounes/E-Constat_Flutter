import 'package:dpc_flutter/constant/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../components/My_button.dart';

class CarDamageB extends StatefulWidget {
  const CarDamageB({super.key});

  @override
  State<CarDamageB> createState() => _CarDamageBState();
}

class _CarDamageBState extends State<CarDamageB> {
  String token = "";

  String topleft = "shield";
  bool topleftbool = false;

  String topright = "shield";
  bool toprightbool = false;

  String middleleft = "shield";
  bool middleleftbool = false;

  String middleright = "shield";
  bool middlerightbool = false;

  String bottomleft = "shield";
  bool bottomleftbool = false;

  String bottomright = "shield";
  bool bottomrightbool = false;

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString('token') ?? '');
      topleftbool = false;
    });
  }

  void saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  void initState() {
//////////////
    super.initState();
    _loadCounter();
  }

  void accidant(BuildContext context) {
    Navigator.pushNamed(context, '/chooseDamageCar');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          // Use Stack widget to overlay the background and image widgets
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'lib/images/backgroundb.png'), // Replace with your background image path
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 150, right: 20, top: 40, bottom: 20),
              child: Image.asset(
                'lib/images/carb.png',
              ),
            ),

            ////top left
            GestureDetector(
              onTap: () {
                setState(() {
                  if (topleft == 'shield') {
                    topleft = 'crash';
                    topleftbool = true;
                  } else {
                    topleft = 'shield';
                    topleftbool = false;
                  }
                  saveData("topleftboolB", topleftbool.toString());
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 30, top: 170, bottom: 20),
                child: Image.asset(
                  'lib/images/$topleft.png',
                ),
              ),
            ),
            ////top right
            GestureDetector(
              onTap: () {
                setState(() {
                  if (topright == 'shield') {
                    topright = 'crash';
                    toprightbool = true;
                  } else {
                    topright = 'shield';
                    toprightbool = false;
                  }

                  saveData("toprightboolB", toprightbool.toString());
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 320, right: 10, top: 170, bottom: 20),
                child: Image.asset(
                  'lib/images/$topright.png',
                ),
              ),
            ),

            //////////middle left
            GestureDetector(
              onTap: () {
                setState(() {
                  if (middleleft == 'shield') {
                    middleleft = 'crash';
                    middleleftbool = true;
                  } else {
                    middleleft = 'shield';
                    middleleftbool = false;
                  }

                  saveData("middleleftboolB", middleleftbool.toString());
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 30, top: 390, bottom: 20),
                child: Image.asset(
                  'lib/images/$middleleft.png',
                ),
              ),
            ),
            ////middle right
            GestureDetector(
              onTap: () {
                setState(() {
                  if (middleright == 'shield') {
                    middleright = 'crash';
                    middlerightbool = true;
                  } else {
                    middleright = 'shield';
                    middlerightbool = false;
                  }

                  saveData("middlerightboolB", middlerightbool.toString());
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 320, right: 10, top: 390, bottom: 20),
                child: Image.asset(
                  'lib/images/$middleright.png',
                ),
              ),
            ),

            /////////bottom left
            GestureDetector(
              onTap: () {
                setState(() {
                  if (bottomleft == 'shield') {
                    bottomleft = 'crash';
                    bottomleftbool = true;
                  } else {
                    bottomleft = 'shield';
                    bottomleftbool = false;
                  }

                  saveData("bottomleftboolB", bottomleftbool.toString());
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 30, top: 620, bottom: 20),
                child: Image.asset(
                  'lib/images/$bottomleft.png',
                ),
              ),
            ),
////bottom right
            GestureDetector(
              onTap: () {
                setState(() {
                  if (bottomright == 'shield') {
                    bottomright = 'crash';
                    bottomrightbool = true;
                  } else {
                    bottomright = 'shield';
                    bottomrightbool = false;
                  }

                  saveData("bottomrightboolB", bottomrightbool.toString());
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 320, right: 10, top: 620, bottom: 20),
                child: Image.asset(
                  'lib/images/$bottomright.png',
                ),
              ),
            ),
            Center(
              child: Image.asset(
                'lib/images/top_view_clipart_20_removebg_preview.png',
                width: 300,
              ),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 70.0, right: 70.0, top: 680),
                child:
                    My_button(onTap: () => accidant(context), text: 'Confirme'),
              ),
            )
            // Add your other widgets here if needed
          ],
        ),
      ),
    );
  }
}

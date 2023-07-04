import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

class MyCars extends StatefulWidget {
  const MyCars({super.key});

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  String token = "";
  String dataUser = "";

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString('token') ?? '');
      final parts = token.split('.');
      final payload = parts[1];
      dataUser = B64urlEncRfc7515.decodeUtf8(payload);
      print(token);
    });
  }

  @override
  void initState() {
//////////////
    super.initState();
    _loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 120),
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
                    fontSize: 30.0,
                  ),
                ),
              ),
            ),
          ),
          Center(child: Text(dataUser)),
        ],
      ),
    );
  }
}

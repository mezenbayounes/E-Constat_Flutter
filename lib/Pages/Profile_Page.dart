import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';



class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
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
          Center(child: Text(dataUser)),
        ],
      ),
    );
  }
}

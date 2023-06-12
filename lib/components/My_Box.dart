import 'package:flutter/material.dart';

class My_Box extends StatelessWidget {
  final String pathImage;
  const My_Box({super.key, required this.pathImage});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white),
        child: Image.asset(pathImage, height: 50));
  }
}

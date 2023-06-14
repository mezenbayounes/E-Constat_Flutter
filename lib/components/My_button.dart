import 'package:flutter/material.dart';

class My_button extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const My_button({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(17),
          margin: EdgeInsets.symmetric(horizontal: 75),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 30, 65, 239),
              borderRadius: BorderRadius.circular(25)),
          child: Center(
              child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ))),
    );
  }
}

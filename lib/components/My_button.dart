import 'package:flutter/material.dart';

class My_button extends StatelessWidget {
  final Function()? onTap;
  const My_button({super.key, required this.onTap});

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
          child: const Center(
              child: Text(
            'LOGIN',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          )
          )
          ),
    );
  }
}

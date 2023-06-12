import 'package:flutter/material.dart';

class My_text_filed extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obsecureText;
  final IconData icon;

  const My_text_filed(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecureText,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
          controller: controller,
          obscureText: obsecureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
               labelText: hintText,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(1.0)),
            fillColor: Colors.grey.shade100,
            filled: true,
            hintStyle: TextStyle(color: Colors.grey[350]),
            prefixIcon: Icon(icon),
          )),
    );
  }
}

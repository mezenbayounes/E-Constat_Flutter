import 'package:dpc_flutter/components/My_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void accidant() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 200),
            Image.asset(
              'lib/images/car_crash_bro.png',
              height: 295,
            ),
            My_button(onTap: accidant, text: 'New Accident Report')
          ],
        )),
      ),
    );
  }
}

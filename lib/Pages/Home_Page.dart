import 'package:dpc_flutter/components/My_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  void accidant(BuildContext context) {
    Navigator.pushNamed(context, '/CarDamageA');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 180),
            Image.asset(
              'lib/images/car_crash_bro.png',
              height: 295,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: My_button(
                  onTap: () => accidant(context), text: 'New Accident Report'),
            )
          ],
        )),
      ),
    );
  }
}

import 'package:dpc_flutter/Pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOutButton extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final String text;
  const LogOutButton(
      {Key? key, required this.onTap, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirmation",style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color: Colors.red)),
              content: const Text("Are you sure you want to log out?",style: TextStyle(fontSize: 18),),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel",style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold,color: Colors.blue)),
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                ),
                TextButton(
                  child: Text("Log Out",style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold,color: Colors.red)),
                  onPressed: () async {
                    Navigator.pop(context); // Close the dialog

                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.clear(); // Clear the shared preferences

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) =>
                          false, // Remove all existing routes from the stack
                    );
                  },
                ),
              ],
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.all(15),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Color.fromARGB(255, 231, 14, 14),
                fontSize: 17,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 265,
              ),
              child: Icon(
                icon,
                // You can adjust the size and style of the icon as desired
                size: 25,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

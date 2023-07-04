import 'package:dpc_flutter/components/My_button_terms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dpc_flutter/components/My_Button_Settings.dart';
import 'package:dpc_flutter/components/My_button_terms.dart';
import 'package:dpc_flutter/components/Logout_Button.dart';

import 'package:dpc_flutter/main.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void visible() {}
  bool isVisible = false;
  bool isVisible2 = false;

  final IconData _iconLight = Icons.wb_sunny;
  final IconData _iconDark = Icons.nights_stay;
  bool iconBool = true;

  @override
  Widget build(BuildContext context) {
    const moonIcon = CupertinoIcons.moon_stars;
    bool getresult() {
      return iconBool;
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
          child: Center(
              child: Column(
        children: [
//Logo
          Image.asset(
            'lib/images/car_accesories_pana.png',
            height: 300,
          ),
          My_Button_Setting(
              onTap: () {
                setState(() {
                  isVisible = !isVisible;
                });
              },
              text: 'General Settings',
              icon: Icons.arrow_forward_ios_rounded),
          Divider(
            color: Colors.grey[300],
            height: 0,
            thickness: 2,
          ),
          Row(
            children: [
              Visibility(
                visible: isVisible,
                maintainAnimation: true,
                maintainState: true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(22.0),
                          child: Text(
                            'Dark mode',
                            style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 118, 115, 115),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 200),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  iconBool = !iconBool;

                                  //print(icondark.IconDL);
                                });
                              },
                              icon: Icon(iconBool ? _iconDark : _iconLight)),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              Visibility(
                visible: isVisible,
                maintainAnimation: true,
                maintainState: true,
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 250),
                      child: Padding(
                        padding: EdgeInsets.only(left: 22),
                        child: Text(
                          'Version',
                          style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 118, 115, 115),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '1.0.1',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 118, 115, 115),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          My_Button_terms(
              onTap: () {
                setState(() {
                  isVisible2 = !isVisible2;
                });
              },
              text: 'Terms And Conditions',
              icon: Icons.arrow_forward_ios_rounded),
          Divider(
            color: Colors.grey[300],
            height: 0,
            thickness: 2,
          ),
          Row(
            children: [
              Visibility(
                visible: isVisible2,
                maintainAnimation: true,
                maintainState: true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'lib/images/terms_and_conditions.png',
                              height: 100,
                              width: 250,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 80.0),
                              child: Text(
                                "TERMS AND CONDITIONS",
                                style: TextStyle(
                                    fontSize: 19,
                                    color: Color.fromARGB(235, 23, 9, 229),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Set container width to screen width
                              padding: const EdgeInsets.all(
                                  19.0), // Add padding for better readability
                              child: const Text(
                                "Welcome to eConstat TN, an app that helps you easily and quickly fill in reports. In order to use the app, you will  need to create an account. By creating an account and using  the app, you agree to be bound by these terms and conditions",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 7, 23, 197)),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Set container width to screen width
                              padding: const EdgeInsets.only(
                                  left:
                                      15), // Add padding for better readability
                              child: const Text(
                                'Data Collection ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Set container width to screen width
                              padding: const EdgeInsets.only(
                                  left: 15,
                                  right:
                                      15), // Add padding for better readability
                              child: const Text(
                                  'eConstat TN collects personal information from you in order to provide you with the best possible experience. This includes information such as your name, email address, address, information about your car, and information about your car s insurance in order to make the process easier, as well as any other information you choose to provide.eConstat TN does not display any advertising to you'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Set container width to screen width
                              padding: const EdgeInsets.only(
                                  left:
                                      15), // Add padding for better readability
                              child: const Text(
                                'Device AccesseConstat ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.only(
                                    left: 15,
                                    right:
                                        15), // Add padding for better readability
                                child: const Text(
                                    'TN requires access to your device s camera in order to function properly. By using the app, you grant eConstat TN permission to access your device s camera.')),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Set container width to screen width
                              padding: const EdgeInsets.only(
                                  left:
                                      15), // Add padding for better readability
                              child: const Text(
                                'Third-Party Integrations ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.only(
                                    left: 15,
                                    right:
                                        15), // Add padding for better readability
                                child: const Text(
                                    'eConstat TN uses a Node.js server to store and process data. By using the app, you agree to the collection, use, and sharing of your data as described in these terms and conditions')),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Set container width to screen width
                              padding: const EdgeInsets.only(
                                  left:
                                      15), // Add padding for better readability
                              child: const Text(
                                'Changes to These Terms',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.only(
                                    left: 15,
                                    right:
                                        15), // Add padding for better readability
                                child: const Text(
                                    'eConstat TN reserves the right to update these terms and conditions at any time. If we make any changes, we will post the revised terms and conditions on this page and will indicate the effective date of the revised terms and conditions. We encourage you to review these terms and conditions periodically to stay informed about our practices.')),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // Set container width to screen width
                              padding: const EdgeInsets.only(
                                  left:
                                      15), // Add padding for better readability
                              child: const Text(
                                'Contact Us',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // Set container width to screen width
                                padding: const EdgeInsets.only(
                                    left: 15,
                                    right:
                                        15), // Add padding for better readability
                                child: const Text(
                                    'If you have any questions about these terms and conditions, please contact us at mezen.bayounes@esprit.tn.')),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 290),
          Divider(
            color: Colors.grey[300],
            height: 0,
            thickness: 2,
          ),
          LogOutButton(onTap: visible, text: 'Log Out', icon: Icons.logout)
        ],
      ))),
    );
  }
}

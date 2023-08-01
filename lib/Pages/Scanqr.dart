import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dpc_flutter/constant/utils.dart' as utils;
import 'package:http/http.dart' as http;

import 'menu.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String _scannedResult = 'No data scanned yet';
  String token = "";

  String carIdB = "";
  String insuranceIdB = "";
  String userIDB = "";
  String carIdA = "";
  String insuranceIdA = "";
  String userIDA = "";
  bool showbutton = false;
  String topleftboolA = "false";
  String toprightboolA = "false";
  String middleleftboolA = "false";
  String middlerightboolA = "false";
  String bottomleftboolA = "false";
  String bottomrightboolA = "false";
  String topleftboolB = "false";
  String toprightboolB = "false";
  String middleleftboolB = "false";
  String middlerightboolB = "false";
  String bottomleftboolB = "false";
  String bottomrightboolB = "false";

  String scannedData = "";

  Future<void> _scanQRCode() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Color to use for the scan window
      'Cancel', // Text to display on the cancel button
      true, // Whether to show the flash icon on the scan window
      ScanMode.QR, // Scan mode (QR code in this case)
    );
    showbutton = true;
    if (!mounted) return; // Avoid calling setState if the widget is not mounted
    setState(() {
      _scannedResult = barcodeScanResult;
      scannedData = barcodeScanResult;
      List<String> parts = scannedData.split('-');
      carIdB = parts[0];
      insuranceIdB = parts[1];
      userIDB = parts[2];
    });
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString('token') ?? '');

      userIDA = (prefs.getString('userId') ?? '');
      carIdA = (prefs.getString('CarIdDamagedCar') ?? '');
      insuranceIdA = (prefs.getString('insuranceIdDamagedCar') ?? '');
      topleftboolA = (prefs.getString('topleftboolA') ?? '');
      toprightboolA = (prefs.getString('toprightboolA') ?? '');
      middleleftboolA = (prefs.getString('middleleftboolA') ?? '');
      middlerightboolA = (prefs.getString('middlerightboolA') ?? '');
      bottomleftboolA = (prefs.getString('bottomleftboolA') ?? '');
      bottomrightboolA = (prefs.getString('bottomrightboolA') ?? '');
      topleftboolB = (prefs.getString('topleftboolB') ?? '');
      toprightboolB = (prefs.getString('toprightboolB') ?? '');
      middleleftboolB = (prefs.getString('middleleftboolB') ?? '');
      middlerightboolB = (prefs.getString('middlerightboolB') ?? '');
      bottomleftboolB = (prefs.getString('bottomleftboolB') ?? '');
      bottomrightboolB = (prefs.getString('bottomrightboolB') ?? '');
    });
  }

  void saveData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 50),
              child: IconButton(
                onPressed: _scanQRCode,
                icon: Icon(
                  Icons.qr_code_scanner_outlined,
                  size: 80,
                  color: const Color.fromARGB(255, 6, 142, 205),
                ),
              ),
            ),
            SizedBox(height: 40),
            const Text(
              "Scan Qr Code  ",
              style: TextStyle(
                fontSize: 25,
                color: const Color.fromARGB(255, 6, 142, 205),
              ),
            ),
            SizedBox(
              height: 300,
            ),
            Column(
              children: [
                Visibility(
                  visible: showbutton,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextButton(
                        onPressed: () {
                          print(token);
                          print('user B');
                          print(userIDB);
                          print(carIdB);
                          print(insuranceIdB);
                          print('/////////////////////////////////');

                          print('user A');
                          print(userIDA);
                          print(carIdA);
                          print(insuranceIdA);
/////////////////////////////////////////////////////////
                          print('////////hetha el A////');
                          print('topleftboolA');

                          print(topleftboolA);
                          print('toprightboolA');
                          print(toprightboolA);

                          print('middleleftboolA');
                          print(middleleftboolA);
                          print('middlerightboolA');
                          print(middlerightboolA);
                          print('bottomleftboolA');
                          print(bottomleftboolA);
                          print('bottomrightboolA');
                          print(bottomrightboolA);
                          print('tawa el B');
                          print('topleftboolB');
                          print(topleftboolB);
                          print('toprightboolB');
                          print(toprightboolB);
                          print('middleleftboolB');
                          print(middleleftboolB);
                          print('middlerightboolB');
                          print(middlerightboolB);
                          print('bottomleftboolB');
                          print(bottomleftboolB);
                          print('bottomrightboolB');
                          print(bottomrightboolB);
//////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////:

                          Map<String, dynamic> reqBody = {
                            "userAId": 1,
                            "carAId": carIdA,
                            "insuranceAId": insuranceIdA,
                            "carDamageA": {
                              "topLeft": topleftboolA,
                              "midLeft": middleleftboolA,
                              "bottomLeft": bottomleftboolA,
                              "topRight": toprightboolA,
                              "midRight": middlerightboolA,
                              "bottomRight": bottomrightboolA
                            },
                            "userBId": userIDB,
                            "carBId": carIdB,
                            "insuranceBId": insuranceIdB,
                            "carDamageB": {
                              "topLeft": topleftboolB,
                              "midLeft": middleleftboolB,
                              "bottomLeft": bottomleftboolB,
                              "topRight": toprightboolB,
                              "midRight": middlerightboolB,
                              "bottomRight": bottomrightboolB
                            }
                          };
                          Map<String, String> headers = {
                            "Authorization": "Bearer $token",
                            "Content-Type": "application/json"
                          };

                          try {
                            showDialog(
                              context: context,
                              barrierDismissible:
                                  false, // Prevent dismissing the dialog by tapping outside
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 0.0,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(16.0),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child:
                                              CircularProgressIndicator(), // Loading icon
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            Uri uri =
                                Uri.http(utils.baseUrlWithoutHttp, "/constat");
                            http
                                .post(uri,
                                    body: json.encode(reqBody),
                                    headers: headers)
                                .then((http.Response response) async {
                              Navigator.pop(
                                  context); // Dismiss the loading dialog

                              // Handle the response based on the status code
                              if (response.statusCode == 200) {
                                // Show success dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 0.0,
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Text(
                                                "Success",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.0),
                                              child: Text(
                                                "Report Sended",
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                              ),
                                            ),
                                            SizedBox(height: 16.0),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ).then((value) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Menu(index: 1)),
                                  );
                                });
                              } else {
                                // Show error dialog
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      elevation: 0.0,
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: const Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Text(
                                                "Error",
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.0),
                                              child: Text(
                                                "Try Again",
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                              ),
                                            ),
                                            SizedBox(height: 16.0),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            });
                          } catch (error) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  elevation: 0.0,
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: const Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(16.0),
                                          child: Text(
                                            "Error",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Text(
                                            "An error occurred while making the request",
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }

//////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////:

                          saveData("topleftboolA", "");
                          saveData("toprightboolA", "");
                          saveData("middleleftboolA", "");
                          saveData("middlerightboolA", "");
                          saveData("bottomleftboolA", "");
                          saveData("bottomrightboolA", "");
                          saveData("topleftboolB", "");
                          saveData("toprightboolB", "");
                          saveData("middleleftboolB", "");
                          saveData("middlerightboolB", "");
                          saveData("bottomleftboolB", "");
                          saveData("bottomrightboolB", "");
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 133, 135, 132),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Center(
                              child: Text(
                                "Send Report",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CameraPreviewPage extends StatefulWidget {
  final CameraDescription camera;

  CameraPreviewPage({required this.camera});

  @override
  _CameraPreviewPageState createState() => _CameraPreviewPageState();
}

class _CameraPreviewPageState extends State<CameraPreviewPage> {
  String _scannedResult = 'No data scanned yet';

  Future<void> _scanQRCode() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Color to use for the scan window
      'Cancel', // Text to display on the cancel button
      true, // Whether to show the flash icon on the scan window
      ScanMode.QR, // Scan mode (QR code in this case)
    );

    if (!mounted) return; // Avoid calling setState if the widget is not mounted

    if (barcodeScanResult == '-1') {
      // User pressed the back button on the scanning screen
      setState(() {
        _scannedResult = 'Scan cancelled';
      });
    } else {
      setState(() {
        _scannedResult = barcodeScanResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _scanQRCode,
              child: Text('Scan QR Code'),
            ),
            SizedBox(height: 20),
            Text(
              'Scanned Result:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              _scannedResult,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

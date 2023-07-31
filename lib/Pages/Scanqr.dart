import 'package:barcode_widget/barcode_widget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  String _scannedResult = 'No data scanned yet';
  String carId = "";
  String token = "";
  String scannedData = "";

  Future<void> _scanQRCode() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666', // Color to use for the scan window
      'Cancel', // Text to display on the cancel button
      true, // Whether to show the flash icon on the scan window
      ScanMode.QR, // Scan mode (QR code in this case)
    );

    if (!mounted) return; // Avoid calling setState if the widget is not mounted
    setState(() {
      _scannedResult = barcodeScanResult;
      scannedData = barcodeScanResult;
      List<String> parts = scannedData.split('-');
      carId = parts[0];
      token = parts[1];
    });
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
              height: 120,
            ),
            Text(
              'car id:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              carId,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'token:',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              token,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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

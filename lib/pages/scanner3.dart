// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class QrCodeScanner extends StatefulWidget {
  @override
  _QrCodeScannerState createState() => _QrCodeScannerState();
  
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  
  final GlobalKey _gLobalkey = GlobalKey();
  QRViewController? controller;
  Barcode? result;
  bool isScanned = false; 
  DateTime? lastScanTime; // Timestamp of the last scan
  late String lastScannedBuildingCode; 
  late String buildingName;

  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      if (!isScanned) {
        setState(() {
          result = event;
          isScanned = true;
        });
        saveScannedData(result!.code!);
      }
    });
    controller.pauseCamera();
    controller.resumeCamera();
  }


Future<void> saveScannedData(String buildingCode) async {
  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    final currentUserUid = currentUser.uid;
    final currentUserEmail = currentUser.email;
    final userRef = FirebaseFirestore.instance.collection('users').doc(currentUserUid);
    final entriesRef = FirebaseFirestore.instance.collection('entries');

    final currentTime = DateTime.now();
    final timeFormat = DateFormat('h:mm a');

    final latestQuery = await userRef
        .collection('entries')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (latestQuery.docs.isNotEmpty) {
      final latestDocumentSnapshot = latestQuery.docs.first;
      final latestBuildingCode = latestDocumentSnapshot.data()['buildingCode'];

      if (latestBuildingCode == buildingCode) {
        final exitTimestamp = latestDocumentSnapshot.data()['exitTimestamp'];

        if (exitTimestamp == '~') {
          // If exitTimestamp is empty, update it
          final latestDocumentRef = latestDocumentSnapshot.reference;
          await latestDocumentRef.update({
            'exitTimestamp': timeFormat.format(currentTime),
          });

          // Show a prompt
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Exit time updated for the previous scan.'),
            ),
          );

          return;
        } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Exit time already exists for the previous scan.'),
          //   ),
          // );
        }
      }
    }
    // Create a new entry for the current building
    final currentEntry = {
      'buildingCode': buildingCode,
      'timestamp': FieldValue.serverTimestamp(),
      'entryTime': timeFormat.format(currentTime), 
      'exitTimestamp': '~', // Empty initially or set a default value if desired
      'userEmail': currentUserEmail,
    };

    await userRef.collection('entries').add(currentEntry);
    await entriesRef.add(currentEntry);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Location logged successfully.'),
      ),
    );

    // Update the last scanned building code
    lastScannedBuildingCode = buildingCode;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(1),
              padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              width: 350,
              child: Text(
                'Scan Building QR Code',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  fontSize: 22.0,
                  color: Color.fromARGB(255, 27, 27, 27),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 300,
              width: 300,
              child: QRView(
                key: _gLobalkey,
                onQRViewCreated: qr,
                overlay: QrScannerOverlayShape(
                  overlayColor: Colors.white,
                  borderColor: Colors.black,
                  borderLength: 40,
                  borderWidth: 20,
                  cutOutSize: MediaQuery.of(context).size.width * 0.8,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: (result != null)
                  ? Text(
                      'Successfully Scanned Your Location!',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0,
                        color: Color.fromARGB(255, 27, 27, 27),
                      ),
                    )
                  : Container(
                      width: 180,
                      height: 60,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: ElevatedButton(
                        child: Text(
                          'SCAN',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: Color.fromARGB(255, 146, 33, 50),
                          textStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

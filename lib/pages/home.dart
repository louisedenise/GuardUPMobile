import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'signup.dart';
import 'report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 60),
              Align(
                alignment: Alignment.center,
                child: Material(
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Container();
                      }
                      var qrCodeData = snapshot.data!['email']; // Fetch the email data from Firestore
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                        width: 300,
                        child: QrImage(
                          data: qrCodeData,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(1),
                padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
                width: 350,
                child: Text(
                  'My QR Code',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    fontSize: 18.0,
                    color: Color.fromARGB(255, 27, 27, 27),
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                    width: 170,
                    child: ElevatedButton(
                      child: Text(
                        'Report',
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Report()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Color.fromARGB(255, 146, 33, 50),
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

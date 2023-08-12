// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_tracing1/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup2 extends StatefulWidget {
  const Signup2({Key? key}) : super(key: key);

  @override
  _Signup2State createState() => _Signup2State();
}

class _Signup2State extends State<Signup2> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  bool showSpinner = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Column(
            children: [
              Container(
              //height: 30,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
              width: 350,
              child: Text('Guard UP',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                    color: Color.fromARGB(255, 213, 61, 92),
                ),
              ),
            ),
        
            Container(
              //height: 55,
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(1),
              padding: EdgeInsets.fromLTRB(10, 25, 0, 0),
              width: 350,
              child: Text('Non-UP Registration',
                textAlign: TextAlign.left,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    fontSize: 21.0,
                    color: Color.fromARGB(255, 27, 27, 27),
                ),
              ),
            )        
              ,
              SizedBox(height: 20),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    elevation: 20,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.65,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                'Full Name',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 27, 27, 27),
                                ),
                              ),
                            ),
                          ),
                          // ... (other parts of the form)

                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 222, 222, 222),
                              filled: true,
                            ),
                          ),

                          SizedBox(height: 20),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                'Mobile Number',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 27, 27, 27),
                                ),
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                'Sample Format: +639*********',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12.0,
                                  color: Color.fromARGB(255, 27, 27, 27),
                                ),
                              ),
                            ),
                          ),

                          TextFormField(
                            controller: _mobileController,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 222, 222, 222),
                              filled: true,
                            ),
                          ),

                          SizedBox(height: 20),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  showSpinner = true;
                                });

                                // Verify the phone number and get OTP
                                await auth.verifyPhoneNumber(
                                  phoneNumber: _mobileController.text,
                                  verificationCompleted: (PhoneAuthCredential credential) async {
                                    // Sign up the user with the verified phone number
                                    UserCredential userCredential = await auth.signInWithCredential(credential);
                                    User? user = userCredential.user;
                                    if (user != null) {
                                      // Save the user information to the database
                                      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                                        'name': _nameController.text,
                                        'phoneNumber': _mobileController.text,
                                      });

                                      // Navigate to the home page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
                                      );
                                    }

                                    setState(() {
                                      showSpinner = false;
                                    });
                                  },
                                  verificationFailed: (FirebaseAuthException e) {
                                    setState(() {
                                      showSpinner = false;
                                    });

                                    String errorMessage =
                                        'An error occurred while verifying the phone number. Please try again later.';
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text(errorMessage),
                                          actions: [
                                            TextButton(
                                              child: Text('OK'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  codeSent: (String verificationId, int? resendToken) {
                                    // Navigate to OTP verification page passing verificationId and resendToken
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  },
                                  codeAutoRetrievalTimeout: (String verificationId) {},
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                backgroundColor: Color.fromARGB(255, 213, 61, 92),
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              child: Container(
                                width: 200,
                                height: 42,
                                alignment: Alignment.center,
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

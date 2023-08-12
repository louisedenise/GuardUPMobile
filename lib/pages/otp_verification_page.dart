import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'homepage.dart';

class OTPVerificationPage extends StatefulWidget {
  final String verificationId;
  final int? resendToken;

  OTPVerificationPage(this.verificationId, this.resendToken);

  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  final _otpController = TextEditingController();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  try {
                    // Create a PhoneAuthCredential using the OTP entered by the user
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: _otpController.text,
                    );

                    // Sign in with the credential
                    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                    User? user = userCredential.user;

                    if (user != null) {
                      // Save the user information to the database
                      // You can also do this here as per your requirement
                      // await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                      //   'name': _nameController.text,
                      //   'phoneNumber': _mobileController.text,
                      // });

                      // Navigate to the home page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
                      );
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Invalid OTP. Please try again.'),
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
                  }
                },
                child: Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

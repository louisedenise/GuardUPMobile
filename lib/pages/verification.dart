import 'package:contact_tracing1/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerificationScreen extends StatefulWidget {
  final ConfirmationResult confirmationResult;
  final String name;
  final String password;

  const VerificationScreen({
    Key? key,
    required this.confirmationResult,
    required this.name,
    required this.password,
  }) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _verificationCodeController = TextEditingController();
  bool showSpinner = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Enter the verification code',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Verification Code',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  showSpinner = true;
                });

                String verificationCode = _verificationCodeController.text.trim();

                try {
                  UserCredential userCredential = await widget.confirmationResult.confirm(verificationCode);
                  User? user = userCredential.user;

                  if (user != null) {
                    // Perform additional actions like updating user profile, etc.

                    // Navigate to the home page
                    Navigator.pushReplacement(
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
                        content: Text('Invalid verification code. Please try again.'),
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
    );
  }
}

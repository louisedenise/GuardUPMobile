// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'landingpage.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool showSpinner = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SingleChildScrollView( // Wrap entire content with SingleChildScrollView
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
                  child: Text(
                    'Guard UP',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Color.fromARGB(255, 146, 33, 50),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.all(1),
                  padding: EdgeInsets.fromLTRB(30, 25, 0, 0),
                  child: Text(
                    'UP Registration',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal,
                      fontSize: 21.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topCenter,
                  child: Material(
                    elevation: 20,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                        width: MediaQuery.of(context).size.width * 0.8,
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  'Sample Format: Juan dela Cruz',
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
                                  'UP Mail',
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
                                  'Sample Format: jdelacruz@up.edu.ph',
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
                              controller: _emailController,
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
                                  'Create Password',
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
                                  'Should have at least 6 characters',
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
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                fillColor: Color.fromARGB(255, 222, 222, 222),
                                filled: true,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  activeColor: Color.fromARGB(255, 146, 33, 50),
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked = newBool;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      'I hereby declare that the information provided in this form is complete, true and correct to the best of my knowledge.',
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
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    showSpinner = true;
                                  });
                    
                                  if (!isChecked!) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                    
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text('Please accept the declaration.'),
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
                                    return;
                                  }
                    
                                  try {
                                    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    );
                                    user = userCredential.user;
                    
                                    final currentDate = DateTime.now();
                                    final formattedDate = DateFormat.yMMMMd().format(currentDate);
                    
                                    await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
                                      'name': _nameController.text,
                                      'email': _emailController.text,
                                      'dateCreated': formattedDate,
                                    });
                    
                                    await user!.updateDisplayName(_nameController.text);
                                    await user!.reload();
                                    user = auth.currentUser;
                    
                                    if (user != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LandingPage()),
                                      );
                                    }
                    
                                    setState(() {
                                      showSpinner = false;
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                    
                                    String errorMessage = '';
                                    if (e.code == 'weak-password') {
                                      errorMessage = 'The password provided is too weak.';
                                    } else if (e.code == 'email-already-in-use') {
                                      errorMessage = 'The account already exists for that email.';
                                    } else {
                                      errorMessage = 'An error occurred. Please check the correct formatting.';
                                    }
                    
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
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor: Color.fromARGB(255, 146, 33, 50),
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
      ),
    );
  }
}

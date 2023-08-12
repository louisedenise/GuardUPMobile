// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_tracing1/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import firebase_core
import 'dart:ui';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  bool? isChecked = false;
  bool? isChecked1a = false;
  bool? isChecked1b = false;
  bool? isChecked2a = false;
  bool? isChecked2b = false;
  bool? isChecked3a = false;
  bool? isChecked3b = false;
  bool? isChecked4a = false;
  bool? isChecked4b = false;

  final TextEditingController _exposureDateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _exposureDateController.dispose();
    _emailController.dispose();
    super.dispose();
  }
  
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Form submitted successfully.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
              );
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
      Navigator.pop(context);
      return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 146, 33, 50),
          title: Row(
            children: [
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                onPressed: () async {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  'Home',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(children: [
            Container(
              //height: 30,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(10, 30, 0, 10),
              width: 350,
              child: Text(
                'Covid-19 Report Form',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: Color.fromARGB(255, 146, 33, 50),
                  //backgroundColor: Color.fromARGB(255, 146, 33, 50),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Material(
                  elevation: 20,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                'Have you tested positive for Covid-19?',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 27, 27, 27),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: isChecked1a,
                                  activeColor: Color.fromARGB(255, 146, 33, 50),
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked1a = newBool;
                                      isChecked1b = false;
                                    });
                                  }),
                              Text('Yes'),
                              Checkbox(
                                  value: isChecked1b,
                                  activeColor: Color.fromARGB(255, 146, 33, 50),
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked1b = newBool;
                                      isChecked1a = false;
                                    });
                                  }),
                              Text('No'),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                'Are you experiencing COVID-19 symptoms?',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 27, 27, 27),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: isChecked2a,
                                  activeColor: Color.fromARGB(255, 146, 33, 50),
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked2a = newBool;
                                      isChecked2b = false;
                                    });
                                  }),
                              Text('Yes'),
                              Checkbox(
                                  value: isChecked2b,
                                  activeColor: Color.fromARGB(255, 146, 33, 50),
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked2b = newBool;
                                      isChecked2a = false;
                                    });
                                  }),
                              Text('No'),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                'Are you currently in quarantine?',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 27, 27, 27),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: isChecked3a,
                                  activeColor: Color.fromARGB(255, 146, 33, 50),
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked3a = newBool;
                                      isChecked3b = false;
                                    });
                                  }),
                              Text('Yes'),
                              Checkbox(
                                  value: isChecked3b,
                                  activeColor: Color.fromARGB(255, 146, 33, 50),
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked3b = newBool;
                                      isChecked3a = false;
                                    });
                                  }),
                              Text('No'),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                'Do you need medical assistance?',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 27, 27, 27),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: isChecked4a,
                                  activeColor: Color.fromARGB(255, 146, 33, 50),
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked4a = newBool;
                                      isChecked4b = false;
                                    });
                                  }),
                              Text('Yes'),
                              Checkbox(
                                  value: isChecked4b,
                                  activeColor: Color.fromARGB(255, 146, 33, 50),
                                  onChanged: (newBool) {
                                    setState(() {
                                      isChecked4b = newBool;
                                      isChecked4a = false;
                                    });
                                  }),
                              Text('No'),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                'Estimated Date of COVID-19 Exposure',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 27, 27, 27),
                                ),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  'Sample Format: June 10, 2023',
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
                            controller: _exposureDateController,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 222, 222, 222),
                              filled: true,
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Text(
                                'Email',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 27, 27, 27),
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              fillColor: Color.fromARGB(255, 222, 222, 222),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
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
                                  }),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    'I hereby declare that the information provided in this form is complete, true and correct to the best of my knowledge.',
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
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
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: ElevatedButton(
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
            onPressed: () async {
              // Check if all necessary inputs are filled
              if ((!isChecked1a! && !isChecked1b!) ||
                  (!isChecked2a! && !isChecked2b!) ||
                  (!isChecked3a! && !isChecked3b!) ||
                  (!isChecked4a! && !isChecked4b!) ||
                  _exposureDateController.text.trim().isEmpty ||
                  _emailController.text.trim().isEmpty ||
                  !isChecked!) {
                // Show an error dialog if any input is missing
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('Please fill all necessary inputs.'),
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
                // Initialize Firebase
                await Firebase.initializeApp();
    
                // Get the current timestamp
                Timestamp currentTime = Timestamp.now();
    
                // Save the form data to Firestore with the timestamp
                await FirebaseFirestore.instance.collection('reports').add({
                  'testedPositive': isChecked1a,
                  'experiencingSymptoms': isChecked2a,
                  'inQuarantine': isChecked3a,
                  'medicalAssistanceNeeded': isChecked4a,
                  'exposureDate': _exposureDateController.text,
                  'email': _emailController.text,
                  'timestamp': currentTime, // Save the current timestamp
                });
    
                // Show the confirmation dialog
                _showConfirmationDialog();
    
                // Navigate to the home page (removed from here)
    
              } catch (error) {
                // Handle any errors that occurred during form submission or initialization
                print('Error: $error');
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Error'),
                      content: Text('An error occurred. Please try again later.'),
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
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Color.fromARGB(255, 146, 33, 50),
                    textStyle:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 20),
          ]),
        ),
      ),
    );
  }
}

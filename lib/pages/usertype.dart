// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:contact_tracing1/pages/signup.dart';
import 'package:contact_tracing1/pages/signup2.dart';
import 'package:flutter/material.dart';

class UserTypePage extends StatefulWidget {
  //const Signup ({Key? key, required String title}) : super(key: key);


  @override
  _UserTypePageState createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 146, 33, 50),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                width: 250,
                height: 100,
                child: Text('Are you a constituent of UP Diliman?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                    fontSize: 22.0,
                    color: Colors.white,
                    ),
                  ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>Signup()),
                        );
                      }, 
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      )
                    ),
                      child: Text('Yes',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                    ),
                  ),

                   Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>Signup2()),
                        );
                      }, 
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      )
                    ),
                      child: Text('No',
                      style: TextStyle(
                        color: Colors.black,
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ), 
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/landingpage.dart';


// void main() {
//   runApp(const MyApp());
// }

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: MyHomePage(title: ''), 
      home: LandingPage(),
      
      debugShowCheckedModeBanner: false,
    );
  }
}

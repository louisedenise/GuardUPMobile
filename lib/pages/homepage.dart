// ignore_for_file: prefer_const_constructors

import 'package:contact_tracing1/pages/history.dart';
import 'package:contact_tracing1/pages/notifications.dart'; // Import the notifications page
import 'package:contact_tracing1/pages/scanner3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  bool hasNewNotifications = false;

  final screens = [
    HomePage(),
    QrCodeScanner(),
    History(),
    Notifications(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromARGB(255, 146, 33, 50),
          title: Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  'Guard UP',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/');
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: screens[_currentIndex],
          ),
          SizedBox(
            height: 70,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Color.fromARGB(255, 19, 18, 18),
              selectedItemColor: Color.fromARGB(255, 250, 249, 251),
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(
                      "assets/qr_code.png",
                    ),
                    size: 35,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(
                      "assets/scanner.png",
                    ),
                    size: 35,
                  ),
                  label: 'Scanner',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(
                      "assets/history.png",
                    ),
                    size: 35,
                  ),
                  label: 'History',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      ImageIcon(
                        AssetImage(
                          "assets/notif.png",
                        ),
                        size: 35,
                      ),
                      if (hasNewNotifications)
                        Positioned(
                          right: 0,
                          child: Icon(
                            Icons.circle,
                            size: 10,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                  label: 'Notifications',
                ),
              ],
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      // When the user taps on the notifications tab, set hasNewNotifications to false
      if (index == 3) {
        hasNewNotifications = false;
      }
    });
  }

  // Call this function to update the hasNewNotifications variable when new notifications are received
  void setHasNewNotifications(bool newValue) {
    setState(() {
      hasNewNotifications = newValue;
    });
  }
}

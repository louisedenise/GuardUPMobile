// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> notifsStream = Stream.empty();

  @override
  void initState() {
    super.initState();
    fetchNotifs();
  }

  void fetchNotifs() {
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    final userEntriesRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserUid).collection('notifications');

    notifsStream = userEntriesRef
        .orderBy('timestamp', descending: true)
        .snapshots(includeMetadataChanges: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(1),
              padding: EdgeInsets.fromLTRB(16, 16, 0, 10),
              width: 350,
              child: Text(
                'Notifications',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                  fontSize: 21.0,
                  color: Color.fromARGB(255, 27, 27, 27),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: notifsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final notifs = snapshot.data!.docs;

                    // Check if there are any unread notifications
                    bool hasNewNotifications = notifs.any((notif) => notif['isRead'] == false);

                    return ListView.builder(
                      itemCount: notifs.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final notif = notifs[index].data();
                        final message = notif['message'];
                        final timestamp = notif['timestamp'] as Timestamp;
                        final dateTime = timestamp.toDate();
                        final formattedDate = DateFormat.yMMMMd().format(dateTime);
                        final formattedTime = DateFormat.jm().format(dateTime);

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                          child: Card(
                            color:Color.fromARGB(255, 238, 228, 228),
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    // Wrap the Row with Expanded widget
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(width: 5.0),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                message,
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16.0,
                                                  fontFamily: 'Poppins',
                                                  letterSpacing: 1.1,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                              Text(
                                                formattedDate,
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 72, 68, 80),
                                                  fontSize: 16.0,
                                                  fontFamily: 'Poppins',
                                                  letterSpacing: 1.1,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                              Text(
                                                formattedTime,
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 72, 68, 80),
                                                  fontSize: 16.0,
                                                  fontFamily: 'Poppins',
                                                  letterSpacing: 1.1,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

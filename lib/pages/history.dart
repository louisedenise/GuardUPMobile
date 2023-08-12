import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> entriesStream;

  @override
  void initState() {
    super.initState();
    fetchEntries();
  }

    final Map<String, String> buildingCodeToName = {
  '1201': 'Asian Center',
  '1202': 'Asian Institute of Tourism',
  '1203': 'College of Architecture',
  '1204': 'Juguilon Hall',
  '1205': 'Albert Hall',
  '1206': 'Villadolid Hall',
  '1207': 'College of Arts and Letters',
  '1208': 'Bulwagang Rizal',
  '1209': "Dean's Office",
  '1210': 'College of Fine Arts',
  '1211': 'Enriquez Hall',
  '1212': 'Tolentino Hall',
  '1213': 'College of Home Economics',
  '1214': 'Child Development Center',
  '1215': 'Craft and Design Laboratory',
  '1216': 'College of Human Kinetics',
  '1217': 'Gym Annex',
  '1218': 'Center for International Studies',
  '1219': 'College of Mass Communication',
  '1220': 'CMC Media Center and DZUP Station',
  '1221': 'Plaridel Hall Annex',
  '1222': 'University Film Institute',
  '1223': 'College of Music',
  '1224': 'College of Music - Annex',
  '1225': 'Center for Ethnomusicology',
  '1226': 'Dance Studio',
  '1227': 'College of Science',
  '1228': 'Institute of Biology',
  '1229': 'Zoology Building',
  '1230': 'Institute of Chemistry',
  '1231': 'Institute of Chemistry - Research',
  '1232': 'Computational Science Research Center',
  '1233': 'Institute of Environmental Science and Meteorology',
  '1234': 'National Institute of Geological Sciences',
  '1235': 'CS Library',
  '1236': 'Institute of Mathematics - Building 1',
  '1237': 'Institute of Mathematics - Building 2',
  '1238': 'The Marine Science Institute',
  '1239': 'National Institute of Molecular Biology and Biotechnology',
  '1240': 'National Institute of Physics',
  '1241': 'Natural Sciences Research Institute',
  '1242': 'Palma Hall',
  '1243': 'Benton Hall',
  '1244': 'Lagmay Hall',
  '1245': 'Faculty Center',
  '1246': 'College of Social Work and Community Development',
  '1247': 'School of Economics',
  '1248': 'Encarnacion Hall',
  '1249': 'College of Education',
  '1250': 'Vidal Tan Hall',
  '1251': 'Science Teachers Training Center',
  '1252': 'UP Integrated School / 3-10',
  '1253': 'UP Integrated School K-2',
  '1254': 'Melchor Hall',
  '1255': 'Institute of Chemical Engineering',
  '1256': 'Institute of Civil Engineering Building 1',
  '1257': 'ICE Building 2',
  '1258': 'ICE Building 3',
  '1259': 'ICE Building 4',
  '1260': 'Department of Computer Science',
  '1261': 'Electrical and Electronics Engineering Institute Building 1',
  '1262': 'Electrical and Electronics Engineering Institute Building 2',
  '1263': 'Environmental and Energy Engineering Program',
  '1264': 'Department of Geodetic Engineering',
  '1265': 'Department of Industrial Engineering and Operations Research',
  '1266': 'Industrial Engineering – Mechanical Engineering Building',
  '1267': 'Department of Mechanical Engineering',
  '1268': 'Department of Mining, Metallurgical and Materials Engineering',
  '1269': 'National Center for Transportation Studies',
  '1270': 'National Engineering Center',
  '1271': 'Engineering Library 2',
  '1272': 'Institute of Islamic Studies',
  '1273': 'College of Law',
  '1274': 'Espiritu Hall',
  '1275': 'Bocobo Hall',
  '1276': 'Law Forum',
  '1277': 'National College of Public Administration and Governance',
  '1278': 'School of Library and Information Studies',
  '1279': 'Bonifacio Hall',
  '1280': 'School of Statistics (New building)',
  '1281': 'School of Statistics (Old building)',
  '1282': 'School of Urban and Management Planning',
  '1283': 'Technology Management Center',
  '1284': 'Virata School of Business',
  '1285': 'University Library',
  '1286': 'Bulwagan ng Dangal',
  '1287': 'Lim Museum',
  '1288': 'Vargas Museum',
  '1289': 'Virata Hall',
  '1290': 'Quezon Hall',
  '1291': 'Office of the Chancellor',
  '1292': 'Balay Internasyonal',
  '1293': 'Diliman Gender Office',
  '1294': 'Diliman Information Office',
  '1295': 'Diliman Legal Office',
  '1296': 'Office for Initiatives in Culture and the Arts',
  '1297': 'Office of Anti-Sexual Harassment',
  '1298': 'Sentro ng Wikang Filipino',
  '1299': 'University Computer Center',
  '1300': 'University Theater',
  '1301': 'Interactive Learning Center Diliman',
  '1302': 'Office for the Advancement of Teaching',
  '1303': 'Interactive Learning Center Diliman',
  '1304': 'General Education Center',
  '1305': 'National Service Training Program',
  '1306': 'Office of the University Registrar',
  '1307': 'Accounting, Budget and Cash Office Building',
  '1308': 'Business Concessions Office, Community Affairs Complex',
  '1309': 'Human Resources Development Office',
  '1310': 'Procurement Service',
  '1311': 'Supply and Property Management Office',
  '1312': 'Utilities Management Team',
  '1313': 'Campus Maintenance Office Housing Office',
  '1314': 'Office of Community Relations',
  '1315': 'Office of the Campus Architect',
  '1316': 'Office of the Chief Security Officer',
  '1317': 'University Health Service',
  '1318': 'UP Diliman Police',
  '1319': 'PHIVOLCS Bldg.',
  '1320': 'Office of Extension Coordination',
  '1321': 'Vinzons Hall',
  '1322': 'Student Disciplinary Tribunal',
  '1323': 'University Food Service',
  '1324': 'Department of Military Science and Tactics',
  '1325': 'University Center for Women\'s Studies',
  '1326': 'UP Press',
  '1327': 'UP Vanguard',
  '1328': 'Acacia Residence Hall',
  '1329': 'Concordia Albarracin Hall',
  '1330': 'Ilang-ilang Residence Hall',
  '1331': 'International Center',
  '1332': 'Ipil Residence Hall',
  '1333': 'Kalayaan Residence Hall',
  '1334': 'Kamagong Residence Hall',
  '1335': 'Kamia Residence Hall',
  '1336': 'Molave Residence Hall',
  '1337': 'Sampaguita Residence Hall',
  '1338': 'Sanggumay Residence Hall',
  '1339': 'UP Centennial Residence Hall',
  '1340': 'Yakal Residence Hall',
  '1341': 'All UP Workers Union',
  '1342': 'Ang Bahay ng Alumni',
  '1343': 'Area 1 Residential Community',
  '1344': 'Area 2 Residential Community',
  '1345': 'Athletes\' Quarters',
  '1346': 'Balay Tsanselor',
  '1347': 'Church of the Risen Lord',
  '1348': 'Citimall and L\'Paseo',
  '1349': 'Commission on Higher Education Commission on Human Rights',
  '1350': 'Development Bank of the Philippines',
  '1351': 'DZUP Tower',
  '1352': 'Executive House',
  '1353': 'Fonacier Hall',
  '1354': 'Ikeda Hall',
  '1355': 'Kalinga Day Care Center',
  '1356': 'Land Bank of the Philippines',
  '1357': 'National Computer Center',
  '1358': 'National Science Complex Amphitheater',
  '1359': 'PAGASA Astronomical Observatory',
  '1360': 'Parish of the Holy Sacrifice',
  '1361': 'Catholic Parish Office',
  '1362': 'Philippine Association of University Women (PAUW) Annex',
  '1363': 'PAUW Day Care Center',
  '1364': 'Philippine Institute of Volcanology and Seismology',
  '1365': 'Philippine National Bank',
  '1366': 'Philippine National Red Cross',
  '1367': 'Philippine Social Science Center',
  '1368': 'Post Office',
  '1369': 'Shopping Center',
  '1370': 'State Auditing and Accounting',
  '1371': 'Tennis Courts',
  '1372': 'Track and Field Oval',
  '1373': 'University Amphitheater',
  '1374': 'University Hotel',
};

  void fetchEntries() {
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    final userEntriesRef =
        FirebaseFirestore.instance.collection('users').doc(currentUserUid).collection('entries');

    entriesStream = userEntriesRef.orderBy('timestamp', descending: true).snapshots(includeMetadataChanges: true);
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
              padding: EdgeInsets.fromLTRB(15, 16, 0, 5),
              width: 350,
              child: Text(
                'Travel History',
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
                stream: entriesStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final entries = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: entries.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final entry = entries[index].data();
                        final buildingName = buildingCodeToName[entry['buildingCode']];
                        final entryDate = (entry['timestamp'] as Timestamp).toDate();
                        final entryTime = (entry['timestamp'] as Timestamp).toDate();
                        final exitTime = entry['exitTimestamp'];
                        //  != null
                        //     ? (entry['exitTimestamp'] as Timestamp).toDate()
                        //     : null;

                        final entryDateFormat = DateFormat('MMMM dd, yyyy');
                        final entryTimeFormat = DateFormat('h:mm a');

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                          child: Card(
                            color: Color.fromARGB(255, 238, 228, 228),
                            elevation: 5.0,
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
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(width: 5.0),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                               Text(
                                                buildingName!.length > 31
                                                    ? '${buildingName.substring(0, 31)}...' // Truncate long names
                                                    : buildingName,
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 72, 68, 80),
                                                  fontSize: 16.0,
                                                  fontFamily: 'Poppins',
                                                  letterSpacing: 1.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.justify,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'Date: ${entryDateFormat.format(entryDate)}',
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 72, 68, 80),
                                                  fontSize: 16.0,
                                                  fontFamily: 'Poppins',
                                                  letterSpacing: 1.1,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                              Text(
                                                'Entry Time: ${entryTimeFormat.format(entryTime)}',
                                                style: TextStyle(
                                                  color: Color.fromARGB(255, 72, 68, 80),
                                                  fontSize: 16.0,
                                                  fontFamily: 'Poppins',
                                                  letterSpacing: 1.1,
                                                ),
                                                textAlign: TextAlign.justify,
                                              ),
                                              if (exitTime != null)
                                                Text(
                                                  'Exit Time: ${exitTime}',
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
                                        ],
                                      ),
                                    ],
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

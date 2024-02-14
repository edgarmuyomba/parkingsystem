import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/ParkingSession.dart';
import '../server.dart';
import 'package:http/http.dart' as http;

class UserSessions extends StatefulWidget {
  const UserSessions({super.key});

  @override
  State<UserSessions> createState() => _UserSessionsState();
}

class _UserSessionsState extends State<UserSessions> {
  // dummy details
  String firebase_id = "17UYlu8zmwxSSzBLqx5d8QQfnvx4";
  String user_name = "John";

  bool is_active = false;
  List<ParkingSession> parking_sessions = [];
  ParkingSession? active_session;

  Future<List<ParkingSession>> fetchUserSessions() async {
    var tmp = await http
        .get(Uri.parse("http://$server:8000/user_sessions/$firebase_id/"));
    List response = jsonDecode(tmp.body) as List;
    return response
        .map((session) =>
            ParkingSession.fromJson(session as Map<String, dynamic>))
        .toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserSessions().then((value) {
      parking_sessions = value;
      if (parking_sessions[0].timestamp_end != null) {
        setState(() {
          is_active = true;
          active_session = parking_sessions[0];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Parking Sessions"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Transform.scale(
                          scale: 0.9,
                          child: Image.asset("assets/active_car.png")),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sheraton Hotel",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text("LV_1 1"),
                          Text("Parked on"),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: null,
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "End Session",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Card(
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Table(
                      border: TableBorder.symmetric(
                        inside: BorderSide(width: 1.0, color: Colors.black26),
                      ),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Parking Lot',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Slot',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Date',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                  ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Data 1'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Data 2'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Data 3'),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Data 3'),
                              ),
                            ),
                          ],
                        ),
                        // Add more rows as needed
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

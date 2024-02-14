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

  void show_message(status_code, message) {
    Color? bg_color = status_code == 200 ? Colors.green : Colors.red[400];
    IconData icon = status_code == 200 ? Icons.check : Icons.fmd_bad_outlined;
    String title = status_code == 200 ? "Success" : "Error";

    double deviceHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            height: 0.2 * deviceHeight,
            decoration: BoxDecoration(
              color: bg_color,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                          ),
                        Icon(
                          icon,
                          color: Colors.white,
                          size: 25,
                          )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      message,
                      style: TextStyle(
                        color: Colors.white
                      ),
                      ),
                  )
                ],
              ),
            ),
          ),
        );
      });
  }

  Future<void> terminate_session() async {
    var response = await http.post(Uri.parse(
        "http://$server:8000/release_slot/${active_session!.lot_uuid}/${active_session!.slot}/$firebase_id/"));
    var message = jsonDecode(response.body);
    show_message(response.statusCode, message);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserSessions().then((value) {
      setState(() {
        parking_sessions = value;
      });
      if (parking_sessions[0].timestamp_end == null) {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (is_active) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Current Session",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Transform.scale(
                              scale: 1,
                              child: Image.asset("assets/active_car.png")),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                active_session!.lot,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(active_session!.slot_number),
                              Text(active_session!.parked_on.split(', ')[0]),
                              SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Terminate Session?"),
                                      content: Text("Are you sure you want to end the current session?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context), 
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                              color: Colors.red
                                            ),
                                            )
                                          ),
                                        TextButton(
                                          onPressed: () => {
                                            Navigator.pop(context),
                                            terminate_session()
                                          }, 
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                              color: Colors.green
                                            ),
                                            )
                                          )
                                      ],
                                    );
                                  }
                                ),
                                child: Card(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
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
                SizedBox(height: 10),
              ],
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Session History",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: DataTable(
                          columns: [
                            DataColumn(
                                label: Expanded(
                              child: Text("Parking Lot"),
                            )),
                            DataColumn(
                                label: Expanded(
                              child: Text("Slot"),
                            )),
                            // DataColumn(
                            //     label: Expanded(
                            //   child: Text("Date"),
                            // )),
                            DataColumn(
                                label: Expanded(
                              child: Text("Amount"),
                            )),
                          ],
                          rows: parking_sessions.map((session) {
                            return DataRow(cells: [
                              DataCell(Text(session.lot)),
                              DataCell(Text(session.slot_number)),
                              // DataCell(Text(session.parked_on.split(', ')[0])),
                              session.amount_accumulated != null
                                  ? DataCell(Text(
                                      session.amount_accumulated.toString()))
                                  : DataCell(Text(
                                      "Ongoing",
                                      style: TextStyle(color: Colors.green),
                                    )),
                            ]);
                          }).toList())),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

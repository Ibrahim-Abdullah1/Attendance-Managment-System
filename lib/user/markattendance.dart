// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:attendance_system/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:slide_to_act/slide_to_act.dart';

class attendance extends StatefulWidget {
  const attendance({Key? key}) : super(key: key);

  @override
  State<attendance> createState() => _attendanceState();
}

class _attendanceState extends State<attendance> {
  String? usermail = FirebaseAuth.instance.currentUser!.email;
  String? userid = FirebaseAuth.instance.currentUser!.uid;
  String TurnIn = "--:--";
  String location = " ";

  @override
  void initState() {
    // TODO: implement initState
    _getRecord();
    super.initState();
  }

  void _getLocation() async {
    List<Placemark> newPlace = await GeocodingPlatform.instance
        .placemarkFromCoordinates(user.lat, user.long, localeIdentifier: "en");

    setState(() {
      location =
          "${newPlace[0].street}, ${newPlace[0].administrativeArea},${newPlace[0].postalCode},${newPlace[0].country}";
    });
  }

  void _getRecord() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Student")
          .where("Email", isEqualTo: usermail)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection("Student")
          .doc(snap.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM YYYY').format(DateTime.now()))
          .get();

      setState(() {
        TurnIn = snap2['TurnIn'];
      });
    } on FirebaseException catch (e) {
      print("Exception Occurs");
    }
    print(TurnIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 35),
              child: const Text(
                "Attendance Portal",
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Student ID: AS12",
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  margin: EdgeInsets.only(top: 18, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    // DateFormat("hh:mm:ss s").format(DateTime.now()),
                    DateFormat('hh:mm:ss a').format(DateTime.now()),
                    style: TextStyle(color: Colors.black54, fontSize: 19),
                  ),
                );
              },
            ),
            Container(
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.centerLeft,
                child: RichText(
                  // ignore: prefer_const_constructors, duplicate_ignore
                  text: TextSpan(
                    text: DateFormat('dd ').format(DateTime.now()),
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      TextSpan(
                          text: DateFormat('MMMM yyyy').format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                    ],
                  ),
                )),
            TurnIn == '--:--'
                ? Container(
                    padding: EdgeInsets.only(top: 24),
                    child: Builder(builder: (context) {
                      final GlobalKey<SlideActionState> _key = GlobalKey();
                      print(TurnIn);

                      return SlideAction(
                        key: _key,
                        text: "Slide to Mark Attendance",
                        outerColor: Colors.white,
                        innerColor: Colors.redAccent,
                        textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                        onSubmit: () async {
                          if (user.lat != 0) {
                            _getLocation();
                            print(location);
                            QuerySnapshot snap = await FirebaseFirestore
                                .instance
                                .collection("Student")
                                .where("Email", isEqualTo: usermail)
                                .get();

                            DocumentSnapshot snap2 = await FirebaseFirestore
                                .instance
                                .collection("Student")
                                .doc(snap.docs[0].id)
                                .collection("Record")
                                .doc(DateFormat('dd MMMM YYYY')
                                    .format(DateTime.now()))
                                .get();

                            try {
                              String TurnIn = snap2['TurnIn'];
                              setState(() {
                                TurnIn =
                                    DateFormat('hh:mm').format(DateTime.now());
                              });
                              await FirebaseFirestore.instance
                                  .collection("Student")
                                  .doc(snap.docs[0].id)
                                  .collection("Record")
                                  .doc(DateFormat('dd MMMM yyyy')
                                      .format(DateTime.now()))
                                  .update({
                                'Date': Timestamp.now(),
                                'TurnIn': TurnIn,
                                'location': location,
                              });
                            } catch (e) {
                              setState(() {
                                TurnIn = DateFormat('hh:mm a')
                                    .format(DateTime.now());
                              });
                              await FirebaseFirestore.instance
                                  .collection("Student")
                                  .doc(snap.docs[0].id)
                                  .collection("Record")
                                  .doc(DateFormat('dd MMMM yyyy')
                                      .format(DateTime.now()))
                                  .set({
                                'Date': Timestamp.now(),
                                'TurnIn':
                                    DateFormat('hh:mm').format(DateTime.now()),
                                'location': location,
                              });
                            }
                            _key.currentState!.reset();
                          } else {
                            Timer(Duration(seconds: 20), () async {
                              _getLocation();
                              print(location);
                              QuerySnapshot snap = await FirebaseFirestore
                                  .instance
                                  .collection("Student")
                                  .where("Email", isEqualTo: usermail)
                                  .get();

                              DocumentSnapshot snap2 = await FirebaseFirestore
                                  .instance
                                  .collection("Student")
                                  .doc(snap.docs[0].id)
                                  .collection("Record")
                                  .doc(DateFormat('dd MMMM YYYY')
                                      .format(DateTime.now()))
                                  .get();

                              try {
                                String TurnIn = snap2['TurnIn'];
                                setState(() {
                                  TurnIn = DateFormat('hh:mm')
                                      .format(DateTime.now());
                                });
                                await FirebaseFirestore.instance
                                    .collection("Student")
                                    .doc(snap.docs[0].id)
                                    .collection("Record")
                                    .doc(DateFormat('dd MMMM yyyy')
                                        .format(DateTime.now()))
                                    .update({
                                  'Date': Timestamp.now(),
                                  'TurnIn': TurnIn,
                                  'location': location,
                                });
                              } catch (e) {
                                setState(() {
                                  TurnIn = DateFormat('hh:mm a')
                                      .format(DateTime.now());
                                });
                                await FirebaseFirestore.instance
                                    .collection("Student")
                                    .doc(snap.docs[0].id)
                                    .collection("Record")
                                    .doc(DateFormat('dd MMMM yyyy')
                                        .format(DateTime.now()))
                                    .set({
                                  'Date': Timestamp.now(),
                                  'TurnIn': DateFormat('hh:mm')
                                      .format(DateTime.now()),
                                  'location': location,
                                });
                              }
                              _key.currentState!.reset();
                            });
                          }
                        },
                      );
                    }),
                  )
                : Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 35),
                    child: const Text(
                      "Attendance Marked",
                      style: TextStyle(color: Colors.black54, fontSize: 16),
                    ),
                  ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 35),
              child: Text(
                "Today's Status",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
            ),
            Container(
                height: 140,
                margin: EdgeInsets.only(top: 17),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(95, 24, 21, 21),
                        blurRadius: 10,
                        offset: Offset(2, 2),
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Turn in time",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                TurnIn,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Location",
                              style: TextStyle(
                                  color: Colors.redAccent, fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: location != " "
                                  ? Text(
                                      "$location",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "Islamabad",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

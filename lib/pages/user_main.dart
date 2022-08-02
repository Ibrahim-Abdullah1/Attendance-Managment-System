import 'package:attendance_system/user/location_service.dart';
import 'package:attendance_system/user/markattendance.dart';
import 'package:attendance_system/user/monthlyreport.dart';
import 'package:attendance_system/user/profile.dart';
import 'package:attendance_system/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class usermain extends StatefulWidget {
  const usermain({Key? key}) : super(key: key);

  @override
  State<usermain> createState() => _usermainState();
}

class _usermainState extends State<usermain> {
  int currentindex = 0;

  String? usermail = FirebaseAuth.instance.currentUser!.email;
  String? userid = FirebaseAuth.instance.currentUser!.uid;

  List<IconData> navigationIcons = [
    FontAwesomeIcons.check,
    FontAwesomeIcons.user,
    FontAwesomeIcons.calendarDays,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _RunLocationService();
    getId();
  }

  void getId() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("Student")
        .where('Email', isEqualTo: usermail)
        .get();

    setState(() {
      user.id = snap.docs[0].id;
    });
  }

  void _RunLocationService() async {
    LocationServices().initializa();

    LocationServices().getlongitude().then((value) {
      setState(() {
        user.long = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: IndexedStack(
        index: currentindex,
        children: [
          new attendance(),
          new profile(),
          new monthlyreport(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.only(
          right: 12.2,
          left: 12.2,
          bottom: 24.2,
        ),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 20,
                offset: Offset(2, 2),
              ),
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < navigationIcons.length; i++) ...<Expanded>{
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentindex = i;
                    });
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          navigationIcons[i],
                          color: i == currentindex
                              ? Color.fromARGB(255, 243, 10, 10)
                              : Colors.black38,
                          size: i == currentindex ? 36 : 30,
                        ),
                        currentindex == i
                            ? Container(
                                margin: const EdgeInsets.only(top: 6),
                                height: 3,
                                width: 22,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: Color.fromARGB(255, 243, 10, 10)),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                )),
              }
            ],
          ),
        ),
      ),
    );
  }
}

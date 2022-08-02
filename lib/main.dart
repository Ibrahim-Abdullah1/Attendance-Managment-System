// ignore_for_file: prefer_const_constructors

import 'package:attendance_system/pages/admin.dart';
import 'package:attendance_system/pages/choicepage.dart';
import 'package:attendance_system/pages/login.dart';
import 'package:attendance_system/pages/register.dart';
import 'package:attendance_system/pages/splash.dart';
import 'package:attendance_system/pages/user_main.dart';
import 'package:attendance_system/user/Liststudents.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:month_year_picker/month_year_picker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> initialized = Firebase.initializeApp();
    return FutureBuilder(
      future: initialized,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: Text("Soemthing Wents wrong"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.active) {
          return CircularProgressIndicator();
        } else {
          return MaterialApp(
            title: "Attendance Managment System",
            home: Adminpage(),
            routes: {
              '/login': ((context) => login()),
              '/register': (context) => register(),
              '/usermain': (context) => usermain(),
              '/liststudents': (context) => liststudents(),
              '/adminhome': (context) => Adminpage(),
            },
            localizationsDelegates: const [
              MonthYearPickerLocalizations.delegate,
            ],
          );
        }
      },
    );
  }
}

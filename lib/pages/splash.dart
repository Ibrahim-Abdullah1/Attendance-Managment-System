import 'dart:async';

import 'package:attendance_system/pages/choicepage.dart';
import 'package:attendance_system/pages/login.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _iconAnimationController;
  late Animation<double> _iconAnimation;

  void handleTimeout() {
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (_) => new MyHomePage()));
  }

  startTimeout() async {
    var duration = const Duration(seconds: 4);
    return new Timer(duration, handleTimeout);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2500));

    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController, curve: Curves.easeIn);
    _iconAnimation.addListener(() => this.setState(() {}));

    _iconAnimationController.forward();

    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Scaffold(
          body: Center(
              child: Image.asset(
        "splash.jpg",
        width: _iconAnimation.value * 280,
        height: _iconAnimation.value * 280,
      ))),
    );
  }
}

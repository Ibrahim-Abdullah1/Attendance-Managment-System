// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last, unnecessary_new

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle btnLable = new TextStyle(
      color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w900);

  @override
  Widget build(BuildContext context) {
    final professorLogo = new Hero(
      tag: 'I am Admin',
      child: new CircleAvatar(
        child: new Container(
            width: 135.0,
            height: 135.0,
            decoration: new BoxDecoration(
              color: const Color(0xff7c94b6),
              image: new DecorationImage(
                image: const AssetImage("admin1.jpg"),
              ),
              borderRadius: new BorderRadius.all(new Radius.circular(80.0)),
            )),
      ),
    );

    final studentLogo = new Hero(
      tag: 'I am Student',
      child: new CircleAvatar(
        child: new Container(
          width: 135.0,
          height: 135.0,
          decoration: new BoxDecoration(
            color: const Color(0xff7c94b6),
            image: new DecorationImage(
              image: const AssetImage("std.png"),
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(80.0)),
          ),
        ),
      ),
    );

    return new Scaffold(
      body: new Builder(
        builder: (BuildContext context) {
          return new Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: new Alignment(1.0, 5.0),
                // 10% of the width, so there are ten blinds.
                colors: [Colors.white, Colors.teal], // whitish to gray
              ),
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new Container(
                      width: 150.0,
                      height: 150.0,
                      child: professorLogo,
                      margin: const EdgeInsets.all(16.0),
                    ),
                  ],
                ),
                new Container(
                  child: new RaisedButton(
                    padding: new EdgeInsets.all(16.0),
                    color: Colors.teal,
                    elevation: 20.0,
                    onPressed: () {
                      null;
                    },
                    child: new Text("I am Admin", style: btnLable),
                    shape: new RoundedRectangleBorder(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(60.0))),
                  ),
                  margin: new EdgeInsets.only(
                      bottom: 16.0, left: 16.0, right: 16.0),
                ),
                new Column(
                  children: <Widget>[
                    new Container(
                      width: 150.0,
                      height: 150.0,
                      child: studentLogo,
                      margin: const EdgeInsets.all(16.0),
                    ),
                  ],
                ),
                new Container(
                  child: new RaisedButton(
                    padding: new EdgeInsets.all(16.0),
                    color: Colors.teal,
                    elevation: 20.0,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/login");
                    },
                    child: new Text("I am Student", style: btnLable),
                    shape: new RoundedRectangleBorder(
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(60.0))),
                  ),
                  margin: new EdgeInsets.only(
                      bottom: 16.0, left: 16.0, right: 16.0),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

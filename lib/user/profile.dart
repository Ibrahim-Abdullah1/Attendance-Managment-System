// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String U_id = FirebaseAuth.instance.currentUser!.uid;

  void UploadProfilePick() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Center(
            child: Card(
              margin: EdgeInsets.only(top: 20),
              color: Colors.white30,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                      child: Text(
                        "Student ID: $U_id",
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        UploadProfilePick();
                      }),
                      child: Container(
                        margin: EdgeInsets.only(top: 60, bottom: 15),
                        alignment: Alignment.center,
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Icon(
                          Icons.photo_camera_back,
                          size: 48,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Change Your Profile Picture",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                      ),
                      child: Center(
                        child: Text(
                          "Save Changes",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

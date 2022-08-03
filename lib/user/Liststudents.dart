import 'package:attendance_system/pages/updateuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class liststudents extends StatefulWidget {
  const liststudents({Key? key}) : super(key: key);

  @override
  State<liststudents> createState() => _liststudentsState();
}

class _liststudentsState extends State<liststudents> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection("Student").snapshots();
  CollectionReference students =
      FirebaseFirestore.instance.collection('Student');

  deleteUser(id) async {
    return students
        .doc(id)
        .delete()
        .then((value) => SnackBar(content: Text("User Deleted")))
        .catchError((error) {
      const SnackBar(content: Text("Error in Deleting User"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Something Wentr wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map(
            (DocumentSnapshot document) {
              Map d = document.data() as Map<String, dynamic>;
              storedocs.add(d);
              d['id'] = document.id;
            },
          ).toList();

          return Scaffold(
            body: Container(
              margin: EdgeInsets.only(top: 48, bottom: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 18.0, left: 6, right: 6, bottom: 8),
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(180),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(children: [
                        TableCell(
                            child: Container(
                          color: Colors.greenAccent,
                          child: const Center(
                            child: Text(
                              "Email",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: Colors.greenAccent,
                          child: const Center(
                            child: Text(
                              "Record",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )),
                        TableCell(
                            child: Container(
                          color: Colors.greenAccent,
                          child: const Center(
                            child: Text(
                              "Action",
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ))
                      ]),
                      for (int i = 0; i < storedocs.length; i++) ...[
                        TableRow(children: [
                          TableCell(
                              child: Container(
                            color: Colors.white24,
                            child: Center(
                              child: Text(
                                storedocs[i]['Email'],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                          TableCell(
                              child: Container(
                            color: Colors.white24,
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "/monthlyreport");
                                },
                                child: const Text(
                                  "Record",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )),
                          TableCell(
                              child: Container(
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) => updateuser(
                                                  id: storedocs[i]['id']))));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      size: 23,
                                      color: Colors.teal,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      deleteUser(storedocs[i]['id']);
                                      // deleteUser(1);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 23,
                                      color: Colors.redAccent,
                                    )),
                              ],
                            ),
                          ))
                        ])
                      ]
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

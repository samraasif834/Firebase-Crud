import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String studentName, studentID, studyProgramID;
  late double studentGPA;

  getStudentName(name) {
    this.studentName = name;
  }

  getstudentID(id) {
    this.studentID = id;
  }

  getStudyProgramID(programID) {
    this.studyProgramID = programID;
  }

  getStudentGPA(gpa) {
    this.studentGPA = double.parse(gpa);
  }

  createData() {
    print("created");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA,
    };

    documentReference.set(students).whenComplete(() {
      print("$studentName created");
    });
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
    documentReference.get().then((snapshot) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      // print(data);
      print("Student Name: ${data['studentName']}");
      print("Student ID: ${data['studentID']}");
      print("Student ProgramID: ${data['studyProgramID']}");
      print("student GPA: ${data['studentGPA']}");
      // return Text("Full Name: ${data['studentName']} ${data['studentID']}");
    });
    print('read');
  }

  updateData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA,
    };

    documentReference.set(students).whenComplete(() {
      print("$studentName created");
    });
    print("updated");
  }

  deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc(studentName);
    documentReference.delete().whenComplete(() {
      print("$studentName deleted");
    });

    print('deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Firebase CRUD"),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String name) {
                  getStudentName(name);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Student ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String id) {
                  getstudentID(id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Study Program ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String programID) {
                  getStudyProgramID(programID);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "GPA",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String gpa) {
                  getStudentGPA(gpa);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    createData();
                  },
                  child: Text("Create"),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    readData();
                  },
                  child: Text("Read"),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    updateData();
                  },
                  child: Text("Update"),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    deleteData();
                  },
                  child: Text("Delete"),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Text("Name")),
                Expanded(child: Text("Student ID")),
                Expanded(child: Text("Study Program ID")),
                Expanded(child: Text("GPA")),
              ],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("MyStudents")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot documentSnapshot =
                            snapshot.data!.docs[index];
                        return Row(
                          children: [
                            Expanded(
                                child: Text(documentSnapshot["studentName"])),
                            Expanded(
                                child: Text(documentSnapshot["studentID"])),
                            Expanded(
                                child:
                                    Text(documentSnapshot["studyProgramID"])),
                            Expanded(
                                child: Text(
                                    documentSnapshot["studentGPA"].toString())),
                          ],
                        );
                      },
                    );
                  } else {
                    return Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ));
  }
}

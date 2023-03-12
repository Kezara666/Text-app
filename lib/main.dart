import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String name;

  
      
  void setName(String name) => this.name = name;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Expanded(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("MyStudents").snapshots(),
            builder: (context, snapshot) {
              return Expanded(
                child: SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(documentSnapshot['studentName']),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),

        ///////////////////////////////////////////////////////////////////////////

        Row(

          children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setName(value);
                },
                decoration: const InputDecoration(
                    labelText: 'යවන්න',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ))),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                inserData();
              },
              icon: Icon(Icons.send))
        ]),
      ]),
    );
  }

  void inserData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc('${name}');
    Map<String, dynamic> student = {
      "studentName": name,
      "studentId": '',
      "studyProgramId": '',
      "studentGPA": ''
    };

    documentReference.set(student).whenComplete(() {
      print('insert');
    });
  }

  void readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc('${name}');

    ///Open AI
    ///
    documentReference.get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      data.forEach((key, value) {
        print(value);
      });
    });
  }

  void deleteData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc('${name}');
    documentReference.delete().whenComplete(() {
      print('${this.name} deleted');
    });
  }
}

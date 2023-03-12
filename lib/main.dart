import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_ip_address/get_ip_address.dart';

import 'package:flutter/material.dart';

void main() async {
  //////////////////////

  /////////////////////
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
  late int ip;
  late String ipAd;
  getIp() async {
    try {
      /// Initialize Ip Address
      var ipAddress = IpAddress(type: RequestType.text);

      /// Get the IpAddress based on requestType.
      dynamic data = await ipAddress.getIpAddress();
      ipAd = data.toString();
      this.ip = int.parse(data.toString().split('.')[3]);
      print("ip ${ip}");
    } on IpAddressException catch (exception) {
      /// Handle the exception.
      print(exception.message);
      ip = 255;
    }
  }

  late String name;

  void setName(String name) => this.name = name;
  final fieldText = TextEditingController();

  void clearText() {
    fieldText.clear();
  }

  @override
  Widget build(BuildContext context) {
    getIp();
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("MyStudents")
                .orderBy("studentGPA", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              getIp();
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
                          title: Text(documentSnapshot['studentName'],
                              style: (int.parse(
                                          documentSnapshot['studyProgramId']) <=
                                      50)
                                  ? TextStyle(color: Colors.blue)
                                  : (int.parse(documentSnapshot[
                                              'studyProgramId']) <=
                                          100)
                                      ? TextStyle(color: Colors.amber)
                                      : (int.parse(documentSnapshot[
                                                  'studyProgramId']) <=
                                              150)
                                          ? TextStyle(color: Colors.green)
                                          : (int.parse(documentSnapshot[
                                                      'studyProgramId']) <=
                                                  200)
                                              ? TextStyle(color: Colors.purple)
                                              : TextStyle(color: Colors.black)),
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

        Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: fieldText,
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
                clearText();
              },
              icon: Icon(Icons.send))
        ]),
      ]),
    );
  }

  void inserData() {
    //////////////////ordering

    ////////////////////////
    final now = DateTime.now().toString();

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyStudents").doc('${name}');
    Map<String, dynamic> student = {
      "studentName": name,
      "studentId": ipAd,
      "studyProgramId": ip.toString(),
      "studentGPA": now
    };

    documentReference.set(student).whenComplete(() {
      name = '';
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

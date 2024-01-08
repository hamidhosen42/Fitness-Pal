// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, unnecessary_new, prefer_const_literals_to_create_immutables, library_prefixes, sort_child_properties_last, unused_field, unused_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../components/custom_card_t.dart';
import '../drawer.dart';
import 'add_trainers.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class TrainersScreen extends StatefulWidget {
  @override
  _TrainersScreenState createState() => _TrainersScreenState();
}

class _TrainersScreenState extends State<TrainersScreen> {
  late DatabaseReference _trainerRef;
  late DatabaseReference _expenseRef;
  late DateTime date;
  late DateTime today;
  late String salary;

  final fireStore = FirebaseFirestore.instance;

  // @override
  // void initState() {
  //   final FirebaseDatabase database = FirebaseDatabase();
  //   _trainerRef = database
  //       .reference()
  //       .child(FirebaseAuth.instance.currentUser!.uid)
  //       .child('Trainers');

  //   _expenseRef = database
  //       .reference()
  //       .child(FirebaseAuth.instance.currentUser!.uid)
  //       .child('Expense');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
        backgroundColor: TColor.secondaryColor,
        elevation: 0.0,
        title: Text('Trainers'),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: TColor.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: TextField(
                        onChanged: (value) => {},
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          contentPadding: const EdgeInsets.only(top: 15.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),


            Expanded(
              child: StreamBuilder(
                stream: fireStore.collection('Trainers').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final List<DocumentSnapshot> documents =
                        snapshot.data!.docs;

                    // Check if there are no documents
                    if (documents.isEmpty) {
                      return const Center(
                        child: Text('No trainers available.'),
                      );
                    }

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final data =
                            documents[index].data() as Map<String, dynamic>;

                        return CustomCardT(
                          name: data['Name'],
                          phoneNumber: data['Phone_Number'],
                          paydate: data['Pay_Date'],
                          salary: data['Salary'],
                          imagePath:
                              'assets/images/baby_child_children_boy-512.png',
                          func1: () => {
                            UrlLauncher.launch(
                                'tel:${data['Phone_Number'].toString()}')
                          },
                          func2: () => {
                            UrlLauncher.launch(
                                'sms:${data['Phone_Number'].toString()}')
                          },
                          func3: () => {
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Renew Salary",
                              desc:
                                  "Are you sure you want to update trainer's salary?",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Renew",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    date = DateTime.parse(
                                        data['Pay_Date'].toString());

                                    today = DateTime.now();
                                    salary = data['Salary'].toString();

                                    fireStore.collection('Trainers').doc(data['id']).update({
                                      "Pay_Date": DateFormat('yyyy-MM-dd')
                                          .format(
                                            date.add(
                                              Duration(days: 30),
                                            ),
                                          )
                                          .toString()
                                    });
                                    // _expenseRef
                                    //     .child(
                                    //       DateFormat('yyyy-MM-dd')
                                    //           .format(today),
                                    //     )
                                    //     .push()
                                    //     .set(
                                    //   {
                                    //     'Title':
                                    //         '${data['Name'].toString()}\'s Trainer Fee',
                                    //     'Amount': salary,
                                    //     'Date': DateFormat('yyyy-MM-dd').format(
                                    //       date.add(
                                    //         Duration(days: 30),
                                    //       ),
                                    //     ),
                                    //     'Details':
                                    //         'Name: ${data['Name'].toString()}\nID: ${""}\nTrainer\'s Monthly Fee',
                                    //   },
                                    // );
                                    Navigator.pop(context);
                                  },
                                  color: Color.fromRGBO(0, 179, 134, 1.0),
                                ),
                                DialogButton(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  color: Colors.red,
                                )
                              ],
                            ).show(),
                          },
                          func4: () => {fireStore.collection("Trainers").doc(data['id']).delete()},
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: TColor.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(TColor.secondaryColor),
                ),
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTrainers(),
                    ),
                  ),
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Text(
                      'Add Trainer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
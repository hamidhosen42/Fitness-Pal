// ignore_for_file: library_prefixes, use_key_in_widget_constructors, deprecated_member_use, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, sort_child_properties_last, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../common/colo_extension.dart';
import '../../components/custom_card_m.dart';
import '../drawer.dart';
import 'add_members.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class MembersScreen extends StatefulWidget {
  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  late DatabaseReference _memberRef;
  late DatabaseReference _incomeRef;
  late DateTime date;
  late DateTime today;
  late String fee;
  final fireStore = FirebaseFirestore.instance;

  // @override
  // void initState() {
  //   final FirebaseDatabase database = FirebaseDatabase();
  //   _memberRef = database
  //       .reference()
  //       .child(FirebaseAuth.instance.currentUser!.uid)
  //       .child('Members');
  //   _incomeRef = database
  //       .reference()
  //       .child(FirebaseAuth.instance.currentUser!.uid)
  //       .child('Income');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
        backgroundColor: TColor.secondaryColor,
        elevation: 0.0,
        title: Text('Members'),
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
                stream: fireStore.collection('Members').snapshots(),
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

                        return CustomCardM(
                          name: data['Name'].toString(),
                          ID:data['ID'].toString(),
                          phoneNumber: data['Phone_Number'].toString(),
                          regdate: data['Reg_Date'].toString(),
                          paydate: data['Payment_Date'].toString(),
                          fee: data['Fee'].toString(),
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
                              title: "Renew Fee",
                              desc:
                                  "Are you sure you want to update member's fee?",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Renew",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    date = DateTime.parse(
                                        data['Payment_Date'].toString());
                                    today = DateTime.now();

                                    fee = data['Fee'].toString();

                                    fireStore.collection("Members").doc().set({
                                      "Payment_Date": DateFormat('yyyy-MM-dd')
                                          .format(
                                            date.add(
                                              Duration(days: 30),
                                            ),
                                          )
                                          .toString()
                                    });
                                    _incomeRef
                                        .child(
                                          DateFormat('yyyy-MM-dd')
                                              .format(today),
                                        )
                                        .push()
                                        .set(
                                      {
                                        'Title':
                                            '${data['Name'].toString()}\'s Member Fee',
                                        'Amount': fee,
                                        'Date': DateFormat('yyyy-MM-dd').format(
                                          date.add(
                                            Duration(days: 30),
                                          ),
                                        ),
                                        'Details':
                                            'Name: ${data['Name'].toString()}\nID: ${""}\nMember\'s Monthly Fee',
                                      },
                                    );
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
                          func4: () => {fireStore.collection("Members").doc(data['id']).delete()},
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
                      builder: (context) => AddMembers(),
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
                      'Add Member',
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
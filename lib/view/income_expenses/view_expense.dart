// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use, prefer_const_constructors, sort_child_properties_last

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../common/colo_extension.dart';
import '../../components/custom_card_money.dart';
import '../drawer.dart';

class ViewExpense extends StatefulWidget {
  @override
  _ViewExpenseState createState() => _ViewExpenseState();
}

class _ViewExpenseState extends State<ViewExpense> {
  late DatabaseReference _expenseRef;
  late DateTime date;
  final fireStore = FirebaseFirestore.instance;

  // @override
  // void initState() {
  //   date = DateTime.now();
  //   String ndate = DateFormat('yyyy-MM-dd').format(date).toString();
  //   final FirebaseDatabase database = FirebaseDatabase();
  //   _expenseRef = database
  //       .reference()
  //       .child(FirebaseAuth.instance.currentUser!.uid)
  //       .child('Expense')
  //       .child(ndate);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
          backgroundColor: TColor.secondaryColor,
          elevation: 0.0,
          title: const Text("View Expenses"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 28.0,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
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
                stream: fireStore.collection('Expense').snapshots(),
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

                        return CustomCardMoney(
                          title: data['Title'].toString(),
                          amount: data['Amount'].toString(),
                          date: data['Date'].toString(),
                          detail: data['Details'].toString(),
                          imagePath:
                              'assets/images/cash_flow_tranfer_finance-512.png',
                          func1: () => {
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Renew Service Date",
                              desc:
                                  "Are you sure you want to renew service date?",
                              buttons: [
                                DialogButton(
                                  child: Text(
                                    "Renew",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    date = DateTime.parse(
                                        data['Service_Date'].toString());

                                    fireStore.collection("Expense").doc().set({
                                      "Service_Date": DateFormat('yyyy-MM-dd')
                                          .format(
                                            date.add(
                                              Duration(days: 120),
                                            ),
                                          )
                                          .toString()
                                    });
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
                          func2: () => {fireStore.collection('Expense').doc(data['id']).delete()},
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
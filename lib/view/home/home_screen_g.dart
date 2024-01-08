// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, sized_box_for_whitespace, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../common/colo_extension.dart';
import '../drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
        backgroundColor: TColor.secondaryColor,
        elevation: 0.0,
        title: Text('Dashboard'),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Income")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final List<DocumentSnapshot> documents =
                                snapshot.data!.docs;
                            // Calculate total amount
                            double totalAmount = 0;
                            for (var document in documents) {
                              final data =
                                  document.data() as Map<String, dynamic>;
                              double amount =
                                  double.tryParse(data['Amount'].toString()) ??
                                      0;
                              totalAmount += amount;
                            }

                            return Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: Wrap(
                                    spacing: 20,
                                    runSpacing: 20.0,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 155.0,
                                        height: 155.0,
                                        child: Card(
                                          color: Colors.grey,
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/increase_presentation_Profit_growth-512.png',
                                                  width: 64.0,
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text(
                                                  'Income',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  "${totalAmount}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Expense")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final List<DocumentSnapshot> documents =
                                snapshot.data!.docs;
                            // Calculate total amount
                            double totalAmount = 0;
                            for (var document in documents) {
                              final data =
                                  document.data() as Map<String, dynamic>;
                              double amount =
                                  double.tryParse(data['Amount'].toString()) ??
                                      0;
                              totalAmount += amount;
                            }

                            return Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: Wrap(
                                    spacing: 20,
                                    runSpacing: 20.0,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 155.0,
                                        height: 155.0,
                                        child: Card(
                                          color: Colors.grey,
                                          elevation: 2.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/decrease_presentation_down_loss-512.png',
                                                  width: 64.0,
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text(
                                                  'Expense',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20.0),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Text(
                                                  "${totalAmount}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Members")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.black),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;

                          return Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20.0,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 155.0,
                                      height: 155.0,
                                      child: Card(
                                        color: Colors.grey,
                                        elevation: 2.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/family_tree_members_people-512.png',
                                                width: 64.0,
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                'Members',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "${documents.length}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Trainers")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.black),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;

                          return Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20.0,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 155.0,
                                      height: 155.0,
                                      child: Card(
                                        color: Colors.grey,
                                        elevation: 2.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/gym_coach_trainer_fitness-512.png',
                                                width: 64.0,
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                'Trainers',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "${documents.length}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Equipments")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child:
                                CircularProgressIndicator(color: Colors.black),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;

                          return Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Wrap(
                                  spacing: 20,
                                  runSpacing: 20.0,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 155.0,
                                      height: 155.0,
                                      child: Card(
                                        color: Colors.grey,
                                        elevation: 2.0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/dumbbell_gym_fitness_exercise-512.png',
                                                width: 64.0,
                                              ),
                                              SizedBox(
                                                height: 10.0,
                                              ),
                                              Text(
                                                'Equipments',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "${documents.length}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                  // StatsGrid('Equipments', '1',
                  //     'assets/images/dumbbell_gym_fitness_exercise-512.png'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

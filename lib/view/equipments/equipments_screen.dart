// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, sort_child_properties_last, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/view/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../common/colo_extension.dart';
import '../../components/custom_card_e.dart';
import 'add_equipments.dart';

class EquipmentsScreen extends StatefulWidget {
  @override
  _EquipmentsScreenState createState() => _EquipmentsScreenState();
}

class _EquipmentsScreenState extends State<EquipmentsScreen> {
  late DatabaseReference _equipmentRef;
  late DateTime date;
  final fireStore = FirebaseFirestore.instance;

  // @override
  // void initState() {
  //   final FirebaseDatabase database = FirebaseDatabase();
  //   _equipmentRef = database
  //       .reference()
  //       .child(FirebaseAuth.instance.currentUser.uid)
  //       .child('Equipments');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
          backgroundColor: TColor.secondaryColor,
          elevation: 0.0,
          title: const Text("Equipments"),
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
                borderRadius: const BorderRadius.only(
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
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          contentPadding: EdgeInsets.only(top: 15.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: fireStore.collection('Equipments').snapshots(),
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

                        return CustomCardE(
                          eqname: data['Equipment_Name'].toString(),
                          category: data['Category'].toString(),
                          servdate: data['Service_Date'].toString(),
                          imagePath:
                              'assets/images/dumbbell_gym_fitness_exercise-512.png',
                          func1: () => {
                            Alert(
                              context: context,
                              type: AlertType.warning,
                              title: "Renew Service Date",
                              desc:
                                  "Are you sure you want to renew service date?",
                              buttons: [
                                DialogButton(
                                  child: const Text(
                                    "Renew",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    date = DateTime.parse(
                                        data['Service_Date'].toString());

                                    fireStore
                                        .collection("Equipments")
                                        .doc()
                                        .set({
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
                                  color: const Color.fromRGBO(0, 179, 134, 1.0),
                                ),
                                DialogButton(
                                  child: const Text(
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
                          func2: () => {fireStore.collection('Equipments').doc(data['id']).delete()},
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
                borderRadius: const BorderRadius.only(
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
                      builder: (context) => AddEquipments(),
                    ),
                  ),
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Text(
                      'Add Equipments',
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

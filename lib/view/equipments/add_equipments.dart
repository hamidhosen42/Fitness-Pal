// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_unnecessary_containers, prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../common/colo_extension.dart';
import '../../components/make_input.dart';

class AddEquipments extends StatefulWidget {
  @override
  _AddEquipmentsState createState() => _AddEquipmentsState();
}

class _AddEquipmentsState extends State<AddEquipments> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController eqnameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController servtermController = TextEditingController();
  final TextEditingController servdateController = TextEditingController()
    ..text = 'Please select a Service / Bought Date.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
          backgroundColor: TColor.secondaryColor,
          elevation: 0.0,
          title: const Text("Add Equipments"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 28.0,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
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
                      child: Center(
                        child: Text(
                          'Enter Details',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MakeInput(
                        label: 'Equipment Name',
                        obscureText: false,
                        controllerID: eqnameController,
                      ),
                      MakeInput(
                        label: 'Category',
                        obscureText: false,
                        controllerID: categoryController,
                      ),
                      MakeInput(
                        label: 'Service Terms',
                        obscureText: false,
                        controllerID: servtermController,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Next Service Date / Bought Date',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          TextField(
                            controller: servdateController,
                            enabled: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0,
                                horizontal: 10.0,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          OutlinedButton(
                            child: Text('Pick a Date'),
                            onPressed: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2100),
                              ).then((_dateTime) {
                                setState(() {
                                  servdateController.text =
                                      DateFormat('yyyy-MM-dd')
                                          .format(_dateTime!);
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                onPressed: () async {
                  try {
                    final data = FirebaseFirestore.instance
                        .collection("Equipments")
                        .doc();
                    await data.set({
                      'id': data.id.toString(),
                      'Equipment_Name': eqnameController.text,
                      'Category': categoryController.text,
                      'Service_Terms': servtermController.text,
                      'Service_Date': servdateController.text,
                    }).then((value) {
                      showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Equipments Added Successfully",
                          ));

                      eqnameController.clear();
                      categoryController.clear();
                      servtermController.clear();
                      servdateController.clear();
                    });
                  } catch (e) {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: e.toString(),
                      ),
                    );
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Text(
                      'Confirm Details',
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
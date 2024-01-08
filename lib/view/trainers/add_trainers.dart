// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, library_private_types_in_public_api, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../components/make_input.dart';

class AddTrainers extends StatefulWidget {
  @override
  _AddTrainersState createState() => _AddTrainersState();
}

class _AddTrainersState extends State<AddTrainers> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _regdateController = TextEditingController()
    ..text = 'Please select a Registration Date.';
  final TextEditingController _qualificationController =
      TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
          backgroundColor: TColor.secondaryColor,
          elevation: 0.0,
          title: Text("Add Trainers"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
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
                borderRadius: BorderRadius.only(
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
                        label: 'Name',
                        obscureText: false,
                        controllerID: _nameController,
                      ),
                      MakeInput(
                        label: 'Address',
                        obscureText: false,
                        controllerID: _addressController,
                      ),
                      MakeInput(
                        label: 'Phone Number',
                        obscureText: false,
                        controllerID: _phoneController,
                      ),
                      MakeInput(
                        label: 'Salary',
                        obscureText: false,
                        controllerID: _salaryController,
                      ),
                      MakeInput(
                        label: 'Qualifications',
                        obscureText: false,
                        controllerID: _qualificationController,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Registration Date',
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
                            controller: _regdateController,
                            enabled: false,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0.0,
                                horizontal: 10.0,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    // color: Colors.grey[400],
                                    color: Colors.grey),
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
                                  _regdateController.text =
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
                        .collection("Trainers")
                        .doc();
                    await data.set({
                      'id': data.id.toString(),
                      'Name': _nameController.text,
                      'Address': _addressController.text,
                      'Phone_Number': _phoneController.text,
                      'Reg_Date': _regdateController.text,
                      'Pay_Date': _regdateController.text,
                      'Qualifications': _qualificationController.text,
                      'Salary': _salaryController.text,
                    }).then((value) {
                      showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Trainers Added Successfully",
                          ));

                      _nameController.clear();
                      _addressController.clear();
                      _phoneController.clear();
                      _regdateController.clear();
                      _qualificationController.clear();
                      _salaryController.clear();
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
                  children: <Widget>[
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

// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../common/colo_extension.dart';
import '../../components/make_input.dart';

class AddIncome extends StatefulWidget {
  @override
  _AddIncomeState createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController dateController = TextEditingController()
    ..text = 'Please select a Date.';
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
          backgroundColor: TColor.secondaryColor,
          elevation: 0.0,
          title: const Text("Add Incomes"),
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
                        label: 'Title',
                        obscureText: false,
                        controllerID: titleController,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date',
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
                            controller: dateController,
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
                                  dateController.text = DateFormat('yyyy-MM-dd')
                                      .format(_dateTime!);
                                });
                              });
                            },
                          ),
                        ],
                      ),
                      MakeInput(
                        label: 'Amount',
                        obscureText: false,
                        controllerID: amountController,
                      ),
                      MakeInput(
                        label: 'Income Details',
                        obscureText: false,
                        controllerID: detailsController,
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
                        .collection("Income")
                        .doc();
                    await data.set({
                      'id': data.id.toString(),
                      'Title': titleController.text,
                      'Amount': amountController.text,
                      'Details': detailsController.text,
                      'Date': dateController.text,
                    }).then((value) {
                      showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.success(
                            message: "Income Added Successfully",
                          ));

                      titleController.clear();
                      amountController.clear();
                      detailsController.clear();
                      dateController.clear();
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
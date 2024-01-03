// ignore_for_file: unused_field, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/view/login/what_your_goal_view.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../common_widget/round_button.dart';
import '../../common_widget/round_textfield.dart';

class CompleteProfileView extends StatefulWidget {
  const CompleteProfileView({super.key});

  @override
  State<CompleteProfileView> createState() => _CompleteProfileViewState();
}

class _CompleteProfileViewState extends State<CompleteProfileView> {
  final user = FirebaseAuth.instance.currentUser;
  String selectedGender = "Choose Gender";
  final _formState = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final _dateController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/img/complete_profile.png",
                  width: media.width,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Text(
                  "Let’s complete your profile",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "It will help us to know more about you!",
                  style: TextStyle(color: TColor.gray, fontSize: 12),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(children: [
                    Form(
                        key: _formState,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: TColor.lightGray,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Image.asset(
                                        "assets/img/gender.png",
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                        color: TColor.gray,
                                      )),
                                  Expanded(
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        items: ["Male", "Female"]
                                            .map((name) => DropdownMenuItem(
                                                  value: name,
                                                  child: Text(
                                                    name,
                                                    style: TextStyle(
                                                        color: TColor.gray,
                                                        fontSize: 14),
                                                  ),
                                                ))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGender = value!;
                                          });
                                        },
                                        isExpanded: true,
                                        hint: Text(
                                          selectedGender,
                                          style: TextStyle(
                                              color: TColor.gray, fontSize: 12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: media.width * 0.04,
                            ),
                            RoundTextField(
                              controller: _dateController,
                              hitText: "Date of Birth",
                              icon: "assets/img/date.png",
                              isRequired: true,
                            ),
                            SizedBox(
                              height: media.width * 0.04,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RoundTextField(
                                    controller: _weightController,
                                    hitText: "Your Weight",
                                    icon: "assets/img/weight.png",
                                    isRequired: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: TColor.secondaryG,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    "KG",
                                    style: TextStyle(
                                        color: TColor.white, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: media.width * 0.04,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RoundTextField(
                                    controller: _heightController,
                                    hitText: "Your Height",
                                    icon: "assets/img/hight.png",
                                    isRequired: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  width: 50,
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: TColor.secondaryG,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    "CM",
                                    style: TextStyle(
                                        color: TColor.white, fontSize: 12),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: media.width * 0.07,
                            ),
                            RoundButton(
                                title: "Next >",
                                onPressed: () {
                                  var ref = FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email);

                                  if (_formState.currentState!.validate()) {
                                    try {
                                      ref
                                          .update({
                                            'gender': selectedGender,
                                            "date": _dateController.text,
                                            "weight": _weightController.text,
                                            "height": _heightController.text
                                          })
                                          .then((value) => showTopSnackBar(
                                                Overlay.of(context),
                                                CustomSnackBar.success(
                                                  message:
                                                      "Complete Profile Successfully",
                                                ),
                                              ))
                                          .then((value) => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const WhatYourGoalView())));
                                    } catch (e) {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.success(
                                          message: "Something is wrong",
                                        ),
                                      );
                                    }
                                  }
                                }),
                          ],
                        ))
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

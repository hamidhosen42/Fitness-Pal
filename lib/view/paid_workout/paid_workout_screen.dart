// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../common/colo_extension.dart';

class PaidWorkoutScreen extends StatefulWidget {
  const PaidWorkoutScreen({super.key});

  @override
  State<PaidWorkoutScreen> createState() => _PaidWorkoutScreenState();
}

class _PaidWorkoutScreenState extends State<PaidWorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(
              "assets/img/black_btn.png",
              width: 15,
              height: 15,
              fit: BoxFit.contain,
            ),
          ),
        ),
        title: Text(
          "Paid Workout",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(),
    );
  }
}
// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/view/home/home_view.dart';
import 'package:flutter/material.dart';

import '../dashboard/navigator.dart';
import '../on_boarding/on_boarding_view.dart';
import '../on_boarding/started_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      user.authStateChanges().listen((event) {
        if (event == null && mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => StartedView()),
              (route) => false);
        } else {
          if (user.currentUser!.email == "sdshuvo4119@gmail.com") {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => BottomNavBar()),
                (route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomeView()),
                (route) => false);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              width: size.width * 0.8,
            ),
          ],
        ),
      ),
    );
  }
}
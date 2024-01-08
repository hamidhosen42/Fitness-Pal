// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_local_variable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../components/round_button.dart';
import '../../../components/round_textfield.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final _formState = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  bool isPasswordSecured = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Forgot here",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 50.h,
              ),
              Form(
                key: _formState,
                child: Column(
                  children: [
                    RoundTextField(
                      controller: _emailController,
                      hitText: "Email",
                      isRequired: true,
                      icon: "assets/img/email.png",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    RoundButton(
                      title: "Sign In",
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        if (_formState.currentState!.validate()) {
                          setState(() {
                            loading = false;
                          });
                          _auth
                              .sendPasswordResetEmail(
                                  email: _emailController.text)
                              .then((value) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.success(
                                message:
                                    "We have sent you email to recover password, please check email",
                              ),
                            );
                            Navigator.pop(context);
                          }).onError((error, stackTrace) {
                            setState(() {
                              loading = true;
                            });
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                message: error.toString(),
                              ),
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'If you need to reset your password, please follow the steps below:\n1. Enter your email address associated with your account.\n2. Check your email for a password reset link. Make sure to check your spam folder if you dont see it in your inbox.\n3. Click on the password reset link and follow the instructions to create a new password.\n4. Once you have created a new password, you should be able to log in to your account with your new password.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
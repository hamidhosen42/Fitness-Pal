// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/view/authentication/complete_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../common_widget/round_button.dart';
import '../../../common_widget/round_textfield.dart';
import '../LoginScreen/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formState = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isPasswordSecured = true;

  final _firstNamelController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70.h,
                ),
                Text(
                  "Hey there,",
                  style: TextStyle(color: TColor.gray, fontSize: 20.sp),
                ),
                Text(
                  "Create an Account",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: media.width * 0.2,
                ),
                Form(
                  key: _formState,
                  child: Column(
                    children: [
                      RoundTextField(
                        controller: _firstNamelController,
                        hitText: "First Name",
                        icon: "assets/img/user_text.png",
                        isRequired: true,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      RoundTextField(
                        controller: _lastNameController,
                        hitText: "Last Name",
                        icon: "assets/img/user_text.png",
                        isRequired: true,
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      RoundTextField(
                        controller: _emailController,
                        hitText: "Email",
                        isRequired: true,
                        icon: "assets/img/email.png",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      RoundTextField(
                        controller: _passwordController,
                        hitText: "Password",
                        isRequired: true,
                        secured: isPasswordSecured,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPasswordSecured = !isPasswordSecured;
                              });
                            },
                            icon: isPasswordSecured
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off)),
                        icon: "assets/img/lock.png",
                      ),
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                      RoundButton(
                        title: "Register",
                        onPressed: () async {
                          if (_formState.currentState!.validate()) {
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text);

                              //! User data get

                              final userData = await FirebaseFirestore.instance
                                  .collection("users")
                                  .where("email",
                                      isEqualTo: _emailController.text)
                                  .get();

                              if (userData.docs.isEmpty) {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(_emailController.text)
                                    .set({
                                  'email': _emailController.text,
                                  'f_name': _firstNamelController.text,
                                  'l_name': _lastNameController.text,
                                  'uid': FirebaseAuth.instance.currentUser!.uid,
                                  "image": "",
                                  "gender": "",
                                  "date": "",
                                  "weight": "",
                                  "height": ""
                                }).then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CompleteProfileView()));

                                  showTopSnackBar(
                                      Overlay.of(context),
                                      CustomSnackBar.success(
                                        message: "SignUp Successfully",
                                      ));
                                });
                              } else {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(_emailController.text)
                                    .update({
                                  'email': _emailController.text,
                                  'f_name': _firstNamelController.text,
                                  'l_name': _lastNameController.text,
                                  'uid': FirebaseAuth.instance.currentUser!.uid,
                                  "image": "",
                                  "gender": "",
                                  "date": "",
                                  "weight": "",
                                  "height": ""
                                }).then((value) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CompleteProfileView()));

                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.success(
                                      message: "SignUp Successfully",
                                    ),
                                  );
                                });
                              }
                            } catch (e) {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message: e.toString(),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()));
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: TColor.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

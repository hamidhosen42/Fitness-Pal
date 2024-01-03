// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/view/login/complete_profile_view.dart';
import 'package:fitness/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../common_widget/custom_button.dart';
import '../../helper/form_helper.dart';

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
                  height: 50.h,
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
                      CutomTextField(
                        controller: _firstNamelController,
                        hintText: "First Name",
                        isRequired: true,
                        icon: "assets/img/user_text.png",
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CutomTextField(
                        controller: _lastNameController,
                        hintText: "Last Name",
                        isRequired: true,
                        icon: "assets/img/user_text.png",
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      CutomTextField(
                        controller: _emailController,
                        hintText: "Email",
                        isRequired: true,
                        icon: "assets/img/email.png",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: media.width * 0.04,
                      ),
                      CutomTextField(
                        controller: _passwordController,
                        hintText: "Password",
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
                      CustomButton(
                        btnTitle: "Register",
                        onTap: () async {
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
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                    Text(
                      "  Or  ",
                      style: TextStyle(color: TColor.black, fontSize: 12),
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      color: TColor.gray.withOpacity(0.5),
                    )),
                  ],
                ),
                SizedBox(
                  height: media.width * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          "assets/img/google.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: media.width * 0.04,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: TColor.white,
                          border: Border.all(
                            width: 1,
                            color: TColor.gray.withOpacity(0.4),
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          "assets/img/facebook.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    )
                  ],
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
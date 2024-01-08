// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/colo_extension.dart';
import '../../components/round_button.dart';
import '../home/home_view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,

      body: SafeArea(
        child: StreamBuilder(
            stream: fireStore
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: ((context, snapshot) {
              final data = snapshot.data;
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              } else {
                // return Text(
                //   "${data!['f_name']} ${data['l_name']}",
                //   style: TextStyle(
                //     fontWeight: FontWeight.w700,
                //     fontSize: 20.sp,
                //     color: TColor.black,
                //   ),
                // );

                return Container(
                  width: media.width,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                      Image.asset(
                        "assets/img/welcome.png",
                        width: media.width * 0.75,
                        fit: BoxFit.fitWidth,
                      ),
                      SizedBox(
                        height: media.width * 0.1,
                      ),
                      Text(
                        "Welcome, ${data!['f_name']} ${data['l_name']}",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "You are all set now, let’s reach your\ngoals together with us",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: TColor.gray, fontSize: 12),
                      ),
                      const Spacer(),
                      RoundButton(
                          title: "Go To Home",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeView()));
                          }),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                );
              }
            })),
      ),

      // body: SafeArea(
      //   child: Container(
      //     width: media.width,
      //     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       mainAxisSize: MainAxisSize.max,
      //       children: [
      //         SizedBox(
      //           height: media.width * 0.1,
      //         ),
      //         Image.asset(
      //           "assets/img/welcome.png",
      //           width: media.width * 0.75,
      //           fit: BoxFit.fitWidth,
      //         ),
      //         SizedBox(
      //           height: media.width * 0.1,
      //         ),
      //         Text(
      //           "Welcome, Stefani",
      //           style: TextStyle(
      //               color: TColor.black,
      //               fontSize: 20,
      //               fontWeight: FontWeight.w700),
      //         ),
      //         Text(
      //           "You are all set now, let’s reach your\ngoals together with us",
      //           textAlign: TextAlign.center,
      //           style: TextStyle(color: TColor.gray, fontSize: 12),
      //         ),
      //         const Spacer(),
      //         RoundButton(
      //             title: "Go To Home",
      //             onPressed: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => HomeView()));
      //             }),
      //         SizedBox(
      //           height: 20.h,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
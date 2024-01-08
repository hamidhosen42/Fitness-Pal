// ignore_for_file: use_key_in_widget_constructors, avoid_function_literals_in_foreach_calls, prefer_const_constructors, unnecessary_this, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/view/home/activity_detail.dart';
import 'package:fitness/view/home/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/colo_extension.dart';
import '../../components/daily_tip.dart';
import '../../components/mage_card_with_internal.dart';
import '../../components/Section.dart';
import '../../components/image_card_with_basic_footer.dart';
import '../../components/main_card_programs.dart';
import '../../model/exercise.dart';

class HomeView extends StatelessWidget {
  final List<Exercise> exercises = [
    Exercise(
      image: 'assets/images/image001.jpg',
      title: 'Easy Start',
      time: '5 min',
      difficult: 'Low',
    ),
    Exercise(
      image: 'assets/images/image002.jpg',
      title: 'Medium Start',
      time: '10 min',
      difficult: 'Medium',
    ),
    Exercise(
      image: 'assets/images/image003.jpg',
      title: 'Pro Start',
      time: '25 min',
      difficult: 'High',
    )
  ];

  List<Widget> generateList(BuildContext context) {
    List<Widget> list = [];
    int count = 0;
    exercises.forEach((exercise) {
      Widget element = Container(
        margin: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          child: ImageCardWithBasicFooter(
            exercise: exercise,
            tag: 'imageHeader$count',
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return ActivityDetail(
                    exercise: exercise,
                    tag: 'imageHeader$count',
                  );
                },
              ),
            );
          },
        ),
      );
      list.add(element);
      count++;
    });
    return list;
  }

  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding:  const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back,",
                          style: TextStyle(color: TColor.gray, fontSize: 12.sp),
                        ),
                        StreamBuilder(
                            stream: fireStore
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .snapshots(),
                            builder: ((context, snapshot) {
                              final data = snapshot.data;
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.black),
                                );
                              } else {
                                return Text(
                                  "${data!['f_name']} ${data['l_name']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp,
                                    color: TColor.black,
                                  ),
                                );
                              }
                            })),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationView(),
                            ),
                          );
                        },
                        icon: Image.asset(
                          "assets/img/notification_active.png",
                          width: 25,
                          height: 25,
                          fit: BoxFit.fitHeight,
                        ))
                  ],
                ),
                MainCardPrograms(), // MainCard
                Section(
                  title: 'Fat burning',
                  horizontalList: this.generateList(context),
                ),
                Section(
                  title: 'Abs Generating',
                  horizontalList: [
                    ImageCardWithInternal(
                      image: 'assets/images/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                    ImageCardWithInternal(
                      image: 'assets/images/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                    ImageCardWithInternal(
                      image: 'assets/images/image004.jpg',
                      title: 'Core \nWorkout',
                      duration: '7 min',
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 50.0),
                  padding: EdgeInsets.only(top: 10.0, bottom: 40.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                  ),
                  child: Column(
                    children: <Widget>[
                      Section(
                        title: "Daily Tips",
                        horizontalList: <Widget>[
                          DailyTip(),
                          DailyTip(),
                          DailyTip(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_local_variable, unused_import, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../common/colo_extension.dart';
import '../../components/round_button.dart';
import '../../main.dart';
import '../Authentication/LoginScreen/login_view.dart';
import '../paid_workout/paid_workout_screen.dart';
import 'profile_edit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  static const routeName = '/profile-screen';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController idController = TextEditingController();

  final fireStore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser;
    // final name = user?.displayName ?? 'No display available';
    // final email = user?.email ?? 'No email available';
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: TColor.white,
            elevation: 0.0,
            title: const Text("Profile"),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: 28.0,
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var data = snapshot.data;
                      return Card(
                        elevation: 1,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      ClipOval(
                                        clipBehavior: Clip.hardEdge,
                                        child: GestureDetector(
                                          onTap: () async {
                                            // Use Navigator to show a full-screen image page
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                  backgroundColor: Colors.grey,
                                                  body: Center(
                                                    child: Hero(
                                                        tag: 'user-avatar',
                                                        child: data['image'] !=
                                                                ""
                                                            ? Image.network(
                                                                data['image'],
                                                                // width: 100,
                                                                // height: 100,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.asset(
                                                                "assets/images/2.png",
                                                                height: 100,
                                                                width: 100,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Hero(
                                              tag: 'user-avatar',
                                              child: data!['image'] != ""
                                                  ? Image.network(
                                                      data['image'],
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Image.asset(
                                                      "assets/images/2.png",
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                    )),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -10,
                                        right: -15,
                                        child: IconButton(
                                          onPressed: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ProfileEditScreen()));
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.black,
                                            size: 30.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            data['f_name'],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            data['l_name'],
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Height: ${data['height']}",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "Weight: ${data['weight']}",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: 2, bottom: 5),
                                        child: Text(data['email']),
                                      ),
                                      // ),
                                    ],
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.work),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Paid Workout',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              Alert(
                                  context: context,
                                  title: "MEMBER",
                                  content: TextField(
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.person),
                                      labelText: 'Your ID',
                                    ),
                                    controller: idController,
                                  ),
                                  buttons: [
                                    DialogButton(
                                      color: TColor.secondaryColor,
                                      onPressed: () async {
                                        Query<Map<String, dynamic>> query =
                                            FirebaseFirestore.instance
                                                .collection("Members")
                                                .where('ID',
                                                    isEqualTo:
                                                        idController.text);

                                        QuerySnapshot<Map<String, dynamic>>
                                            snapshot =
                                            await query.limit(1).get();

                                        if (snapshot.docs.isNotEmpty) {
                                          Map<String, dynamic> data =
                                              snapshot.docs[0].data();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PaidWorkoutScreen(data: data),
                                            ),
                                          );
                                        } else {
                                          showTopSnackBar(
                                            Overlay.of(context),
                                            CustomSnackBar.error(
                                              message:
                                                  "Please give me correct Id",
                                            ),
                                          );
                                        }

                                        idController.clear();
                                      },
                                      child: Text(
                                        'SUBMIT',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.support),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Support',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              // await Get.toNamed(supportScreen);
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.privacy_tip),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Privacy',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              // await Get.toNamed(privacyPolicy);
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.question_answer),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'FAQ',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              // await Get.toNamed(faqScreen);
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Card(
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.language),
                            SizedBox(
                              width: 10.h,
                            ),
                            Text(
                              'Language',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async {
                              // await Get.toNamed(faqScreen);
                            },
                            icon: const Icon(Icons.arrow_forward_ios_rounded))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    // // Get.offAll(() => LoginPage());
                    //   Navigator.push(context,
                    //     MaterialPageRoute(builder: (_) => LoginView()));
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => LoginView()),
                        (route) => false);

                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.success(
                        message: "'Log out",
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 10,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.logout),
                                SizedBox(
                                  width: 10.h,
                                ),
                                Text(
                                  'LogOut',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            // IconButton(
                            //     onPressed: () async {
                            //       // await Get.toNamed(faqScreen);
                            //     },
                            //     icon: const Icon(Icons.arrow_forward_ios_rounded))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

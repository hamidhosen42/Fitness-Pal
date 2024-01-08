// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/colo_extension.dart';
import 'excercise.dart';

class PaidWorkoutScreen extends StatefulWidget {
  Map<String, dynamic> data;

  PaidWorkoutScreen({required this.data});

  @override
  State<PaidWorkoutScreen> createState() => _PaidWorkoutScreenState();
}

class _PaidWorkoutScreenState extends State<PaidWorkoutScreen> {
  final fireStore = FirebaseFirestore.instance;

  List week = [
    "Beginner",
    "Intermediate",
    "Professional",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Workout",
          style: TextStyle(
              color: TColor.black, fontSize: 20, fontWeight: FontWeight.w700),
        ),
        elevation: 0.0,
        backgroundColor: TColor.white,
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Get your body changing within 3 Courses',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Regular physical activity, along with wholesome nutrition, is the foundation for a healthy lifestyle. Exercising your body and eating healthily can at times be quite challenging.  ',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),
              SizedBox(
                height: 15,
              ),
              // widget.data['id']
              // SizedBox(
              //   height: 200,
              //   child: StreamBuilder(
              //       stream: fireStore
              //           .collection("Members")
              //           .doc()
              //           .collection("workout")
              //           .snapshots(),
              //       builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return const Center(
              //             child: CircularProgressIndicator(color: Colors.black),
              //           );
              //         } else if (snapshot.hasError) {
              //           return Text('Error: ${snapshot.error}');
              //         } else {
              //           var data = snapshot.data!.docs;
              //           return ListView.builder(
              //               itemCount: data.length,
              //               itemBuilder: (context, index) {
              //                 return ListTile(
              //                   title:  Text(data[index]['week']),
              //                 );
              //               });
              //         }
              //       })),
              // ),
              Container(
                height: 700.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 0.2,
                          offset: Offset(0.3, 0.5),
                          spreadRadius: 0.5)
                    ]),
                child: ListView.builder(
                    itemCount: week.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      Excercise(text: week[index])));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(week[index],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            // trailing: Container(
                            //   decoration: BoxDecoration(
                            //     color: Colors.yellow,
                            //     borderRadius: BorderRadius.circular(50),
                            //   ),
                            //   child: Icon(
                            //     Icons.check,
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ),
                        ),
                      );
                    }),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(15),
              //       boxShadow: [
              //         BoxShadow(
              //             color: Colors.black12,
              //             blurRadius: 0.2,
              //             offset: Offset(0.3, 0.5),
              //             spreadRadius: 0.5)
              //       ]),
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (_) => Excercise(text: "Day 2")));
              //     },
              //     child: ListTile(
              //       title: Text('Day 2',
              //           style: TextStyle(
              //               fontSize: 20, fontWeight: FontWeight.bold)),
              //       subtitle: Text('10 exercises',
              //           style: TextStyle(
              //               fontSize: 15, fontWeight: FontWeight.normal)),
              //       trailing: Container(
              //         decoration: BoxDecoration(
              //           color: Colors.yellow,
              //           borderRadius: BorderRadius.circular(50),
              //         ),
              //         child: Icon(
              //           Icons.check,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(15),
              //       boxShadow: [
              //         BoxShadow(
              //             color: Colors.black12,
              //             blurRadius: 0.2,
              //             offset: Offset(0.3, 0.5),
              //             spreadRadius: 0.5)
              //       ]),
              //   child: InkWell(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (_) => Excercise(text: "Day 3")));
              //     },
              //     child: ListTile(
              //       title: Text('Day 3',
              //           style: TextStyle(
              //               fontSize: 20, fontWeight: FontWeight.bold)),
              //       subtitle: Text('10 exercises',
              //           style: TextStyle(
              //               fontSize: 15, fontWeight: FontWeight.normal)),
              //       trailing: Container(
              //         decoration: BoxDecoration(
              //           color: Colors.yellow,
              //           borderRadius: BorderRadius.circular(50),
              //         ),
              //         child: Icon(
              //           Icons.check,
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(15),
              //       boxShadow: [
              //         BoxShadow(
              //             color: Colors.black12,
              //             blurRadius: 0.2,
              //             offset: Offset(0.3, 0.5),
              //             spreadRadius: 0.5)
              //       ]),
              //   child: ListTile(
              //     title: Text('Day 4',
              //         style:
              //             TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              //     subtitle: Text('10 exercises',
              //         style: TextStyle(
              //             fontSize: 15, fontWeight: FontWeight.normal)),
              //     trailing: Container(
              //       decoration: BoxDecoration(
              //         color: Colors.yellow,
              //         borderRadius: BorderRadius.circular(50),
              //       ),
              //       child: Icon(
              //         Icons.check,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.yellow,
      //   materialTapTargetSize: MaterialTapTargetSize.padded,
      //   onPressed: () {
      //     // Navigator.push(context, MaterialPageRoute(builder: (context)=> Excercise()));
      //   },
      //   child: Icon(
      //     Icons.local_hospital,
      //     size: 30,
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // bottomNavigationBar: BottomBar(),
    );
  }
}
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, deprecated_member_use, library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../common/colo_extension.dart';

class Excercise extends StatefulWidget {
  final String? text;

  Excercise({this.text});

  @override
  State<Excercise> createState() => _ExcerciseState();
}

class _ExcerciseState extends State<Excercise> {
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      appBar: AppBar(
        title: Text(
          widget.text.toString(),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,
        backgroundColor: TColor.white,
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
      ),

      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: StreamBuilder(
          stream: fireStore
              .collection("workout")
              .where('week', isEqualTo: widget.text)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    var names = data['name'] as List<dynamic>;
                    var urls = data['url'] as List<dynamic>;
                    var subname = data['sub_name'] as List<dynamic>;

                    List<Widget> nameWidgets =
                        names.asMap().entries.map((entry) {
                      int index = entry.key;
                      String name = entry.value.toString();
                      String url = urls[index].toString();
                      String sub_name = subname[index].toString();

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 0.2,
                              offset: Offset(0.3, 0.5),
                              spreadRadius: 0.5,
                            )
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            UrlLauncher.launch(url);
                          },
                          child: ListTile(
                            title: Text(
                              name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(sub_name,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ),
                      );
                    }).toList();

                    // Return a Column with the ListTile widgets
                    return Column(
                      children: nameWidgets,
                    );
                  }),
                ),
              );
            }
          },
        ),
      ),

      //           Container(
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
      //     leading: CircleAvatar(
      //       backgroundImage:
      //           ExactAssetImage('assets/images/climbers.jpg'),
      //       radius: 25,
      //     ),
      //     title: Text('Climbers',
      //         style:
      //             TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      //     subtitle: Text('25 reps, 4 sets',
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

      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(14.0),
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: <Widget>[
      //         Container(
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(15),
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Colors.black12,
      //                     blurRadius: 0.2,
      //                     offset: Offset(0.3, 0.5),
      //                     spreadRadius: 0.5)
      //               ]),
      //           child: InkWell(
      //             onTap: (){
      //                UrlLauncher.launch("https://www.youtube.com/watch?v=JyCG_5l3XLk&ab_channel=Howcast");
      //             },
      //             child: ListTile(
      //               leading: CircleAvatar(
      //                 backgroundImage:
      //                     ExactAssetImage('assets/images/pushups.jpg'),
      //                 radius: 25,
      //               ),
      //               title: Text('Push ups',
      //                   style:
      //                       TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      //               subtitle: Text('25 reps, 4 sets',
      //                   style: TextStyle(
      //                       fontSize: 15, fontWeight: FontWeight.normal)),
      //               trailing: Container(
      //                 decoration: BoxDecoration(
      //                   color: Colors.yellow,
      //                   borderRadius: BorderRadius.circular(50),
      //                 ),
      //                 child: Icon(
      //                   Icons.check,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         Container(
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(15),
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Colors.black12,
      //                     blurRadius: 0.2,
      //                     offset: Offset(0.3, 0.5),
      //                     spreadRadius: 0.5)
      //               ]),
      //           child: ListTile(
      //             leading: CircleAvatar(
      //               backgroundImage:
      //                   ExactAssetImage('assets/images/crunches.jpg'),
      //               radius: 25,
      //             ),
      //             title: Text('Crunches',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      //             subtitle: Text('30 reps, 2 sets',
      //                 style: TextStyle(
      //                     fontSize: 15, fontWeight: FontWeight.normal)),
      //             trailing: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.yellow,
      //                 borderRadius: BorderRadius.circular(50),
      //               ),
      //               child: Icon(
      //                 Icons.check,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         Container(
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(15),
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Colors.black12,
      //                     blurRadius: 0.2,
      //                     offset: Offset(0.3, 0.5),
      //                     spreadRadius: 0.5)
      //               ]),
      //           child: ListTile(
      //             leading: CircleAvatar(
      //               backgroundImage:
      //                   ExactAssetImage('assets/images/planks.jpg'),
      //               radius: 25,
      //             ),
      //             title: Text('Planks',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      //             subtitle: Text('60 secs, 2 sets',
      //                 style: TextStyle(
      //                     fontSize: 15, fontWeight: FontWeight.normal)),
      //             trailing: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.yellow,
      //                 borderRadius: BorderRadius.circular(50),
      //               ),
      //               child: Icon(
      //                 Icons.check,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         Container(
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(15),
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Colors.black12,
      //                     blurRadius: 0.2,
      //                     offset: Offset(0.3, 0.5),
      //                     spreadRadius: 0.5)
      //               ]),
      //           child: ListTile(
      //             leading: CircleAvatar(
      //               backgroundImage:
      //                   ExactAssetImage('assets/images/climbers.jpg'),
      //               radius: 25,
      //             ),
      //             title: Text('Climbers',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      //             subtitle: Text('25 reps, 4 sets',
      //                 style: TextStyle(
      //                     fontSize: 15, fontWeight: FontWeight.normal)),
      //             trailing: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.yellow,
      //                 borderRadius: BorderRadius.circular(50),
      //               ),
      //               child: Icon(
      //                 Icons.check,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         Container(
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(15),
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Colors.black12,
      //                     blurRadius: 0.2,
      //                     offset: Offset(0.3, 0.5),
      //                     spreadRadius: 0.5)
      //               ]),
      //           child: ListTile(
      //             leading: CircleAvatar(
      //               backgroundImage:
      //                   ExactAssetImage('assets/images/squats.jpg'),
      //               radius: 25,
      //             ),
      //             title: Text('Squats',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      //             subtitle: Text('20 reps, 3 sets',
      //                 style: TextStyle(
      //                     fontSize: 15, fontWeight: FontWeight.normal)),
      //             trailing: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.yellow,
      //                 borderRadius: BorderRadius.circular(50),
      //               ),
      //               child: Icon(
      //                 Icons.check,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         Container(
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(15),
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Colors.black12,
      //                     blurRadius: 0.2,
      //                     offset: Offset(0.3, 0.5),
      //                     spreadRadius: 0.5)
      //               ]),
      //           child: ListTile(
      //             leading: CircleAvatar(
      //               backgroundImage:
      //                   ExactAssetImage('assets/images/sideplanks.jpg'),
      //               radius: 25,
      //             ),
      //             title: Text('Side Planks',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      //             subtitle: Text('60 secs, 2 sets',
      //                 style: TextStyle(
      //                     fontSize: 15, fontWeight: FontWeight.normal)),
      //             trailing: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.yellow,
      //                 borderRadius: BorderRadius.circular(50),
      //               ),
      //               child: Icon(
      //                 Icons.check,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //         SizedBox(
      //           height: 15,
      //         ),
      //         Container(
      //           decoration: BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.circular(15),
      //               boxShadow: [
      //                 BoxShadow(
      //                     color: Colors.black12,
      //                     blurRadius: 0.2,
      //                     offset: Offset(0.3, 0.5),
      //                     spreadRadius: 0.5)
      //               ]),
      //           child: ListTile(
      //             leading: CircleAvatar(
      //               backgroundImage:
      //                   ExactAssetImage('assets/images/situps.jpg'),
      //               radius: 25,
      //             ),
      //             title: Text('Sit ups',
      //                 style:
      //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      //             subtitle: Text('25 reps, 4 sets',
      //                 style: TextStyle(
      //                     fontSize: 15, fontWeight: FontWeight.normal)),
      //             trailing: Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.yellow,
      //                 borderRadius: BorderRadius.circular(50),
      //               ),
      //               child: Icon(
      //                 Icons.check,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
    );
  }
}
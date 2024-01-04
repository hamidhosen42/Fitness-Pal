// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use, prefer_const_constructors, unnecessary_new

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final referenceDatabase = FirebaseDatabase.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController gymnameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late DatabaseReference _detailRef;


  @override
  void initState() {
    final FirebaseDatabase database = FirebaseDatabase();
    _detailRef = database
        .reference()
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('Details');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase.reference();
    return Container(
      width: 250.0,
      child: Drawer(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          color: TColor.secondaryColor,
          child: Center(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn1.iconfinder.com/data/icons/engineer-construction/512/engineer_worker_avatar_mechanics-256.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                child: Column(
                  children: [
                    // Flexible(
                    //   child: new FirebaseAnimatedList(
                    //       shrinkWrap: true,
                    //       query: _detailRef,
                    //       itemBuilder: (
                    //         BuildContext context,
                    //         DataSnapshot snapshot,
                    //         Animation<double> animation,
                    //         int index,
                    //       ) 
                    //       {
                    //         return CustomDG(
                    //           name: snapshot.value['Name'].toString(),
                    //           gymname: snapshot.value['GYM_Name'].toString(),
                    //           description:
                    //               snapshot.value['Description'].toString(),
                    //         );
                    //       }
                    //       ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                FirebaseAuth.instance.currentUser!.email.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
              SizedBox(height: 10.0),
              Text('Update Your Details in Settings!'),
              SizedBox(height: 10.0),
              Divider(color: Colors.black),
              IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () => {
                        // Alert(
                        //     context: context,
                        //     title: "DETAILS",
                        //     content: Column(
                        //       children: <Widget>[
                        //         TextField(
                        //           decoration: InputDecoration(
                        //             icon: Icon(Icons.person),
                        //             labelText: 'Your name',
                        //           ),
                        //           controller: nameController,
                        //         ),
                        //         TextField(
                        //           decoration: InputDecoration(
                        //             icon: Icon(Icons.home_rounded),
                        //             labelText: 'GYM name',
                        //           ),
                        //           controller: gymnameController,
                        //         ),
                        //         TextField(
                        //           decoration: InputDecoration(
                        //             icon: Icon(Icons.info),
                        //             labelText: 'Description',
                        //           ),
                        //           controller: descriptionController,
                        //         ),
                        //       ],
                        //     ),
                        //     buttons: [
                        //       // DialogButton(
                        //       //   color: Palette.secondaryColor,
                        //       //   onPressed: () => {
                        //       //     ref
                        //       //         .child(auth.currentUser.uid)
                        //       //         .child('Details')
                        //       //         .child('1')
                        //       //         .set(
                        //       //       {
                        //       //         'Name': nameController.text,
                        //       //         'GYM_Name': gymnameController.text,
                        //       //         'Description': descriptionController.text,
                        //       //       },
                        //       //     ).asStream(),
                        //       //     nameController.clear(),
                        //       //     gymnameController.clear(),
                        //       //     descriptionController.clear(),
                        //       //   },
                        //       //   child: Text(
                        //       //     'UPDATE',
                        //       //     style: TextStyle(
                        //       //         color: Colors.white, fontSize: 20),
                        //       //   ),
                        //       // )
                        //     ]).show()
                      }),
              Text(
                'Settings',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
              Divider(color: Colors.black),
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                tooltip: 'Log Out of the App',
                onPressed: () => {
                  // context.read<AuthenticationService>().signOut(),
                },
              ),
              Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
              Divider(color: Colors.black),
            ],
          )),
        ),
      ),
    );
  }
}
// ignore_for_file: use_key_in_widget_constructors, sort_child_properties_last, unnecessary_this, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class MainCardPrograms extends StatelessWidget {
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: fireStore.collection("For You").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final documents = snapshot.data!.docs;

          // Assuming you want to display the first document
          final firstDocument = documents.isNotEmpty ? documents[0] : null;

          if (firstDocument != null) {
            return InkWell(
              onTap: () {
             UrlLauncher.launch(firstDocument['url']);
              },
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          firstDocument['title'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          firstDocument['time'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[400]!.withOpacity(0.95),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                width: size.width - 40,
                height: (size.width - 40) / 2,
                margin: EdgeInsets.only(
                  top: 30.0,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(firstDocument['image']),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 25.0,
                      offset: Offset(8.0, 8.0),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Handle the case where there are no documents
            return Text('No documents available');
          }
        }
      },
    );
  }
}

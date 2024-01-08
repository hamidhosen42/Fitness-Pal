// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomDG extends StatefulWidget {
  final String? f_name;
  final String? l_name;
  final String? gymname;
  final String? description;
  const CustomDG({this.f_name,this.l_name, this.gymname, this.description});
  @override
  _CustomDGState createState() => _CustomDGState();
}

class _CustomDGState extends State<CustomDG> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Owner:',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        const SizedBox(height: 5.0),
        Text(
          "${widget.f_name.toString()} ${widget.l_name.toString()}",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        SizedBox(height: 10.0),
        Text(
          'GYM Name:',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        SizedBox(height: 5.0),
        Text(
          widget.gymname.toString(),
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
    
      ],
    );
  }
}
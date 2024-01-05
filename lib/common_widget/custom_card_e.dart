// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomCardE extends StatefulWidget {
  final String? eqname;
  final String? category;
  final String? servdate;
  final String? imagePath;
  final void Function()? func1;
  final void Function()? func2;

  CustomCardE({
    this.eqname,
    this.category,
    this.servdate,
    this.imagePath,
    this.func1,
    this.func2,
  });
  @override
  _CustomCardEState createState() => _CustomCardEState();
}

class _CustomCardEState extends State<CustomCardE> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8.0),
      color: Colors.grey[350],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: Image.asset(
                  widget.imagePath.toString(),
                  width: 64.0,
                ),
              ),
              Column(
                children: [
                  Text(
                    widget.eqname.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  Text(
                    'Category: ${widget.category}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0),
                  ),
                  Text(
                    'Bought / Next Service Date: \n${widget.servdate}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0),
                  ),
                ],
              ),
              Flexible(
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  tooltip: 'Delete Equipment',
                  onPressed:widget.func2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
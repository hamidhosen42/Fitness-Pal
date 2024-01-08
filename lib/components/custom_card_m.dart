//Custom Card For Members

// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomCardM extends StatefulWidget {
  final String? name;
  final String? phoneNumber;
  final String? regdate;
  final String? paydate;
  final String? fee;
  final String? imagePath;
  final String? ID;
  final void Function()? func1;
  final void Function()? func2;
  final void Function()? func3;
  final void Function()? func4;

  CustomCardM(
      {this.name,
      this.ID,
      this.phoneNumber,
      this.regdate,
      this.paydate,
      this.fee,
      this.imagePath,
      this.func1,
      this.func2,
  this.func3,
      this.func4});
  @override
  _CustomCardMState createState() => _CustomCardMState();
}

class _CustomCardMState extends State<CustomCardM> {
  late DateTime date;
  late Color timeColor;
  @override
  Widget build(BuildContext context) {
    date = DateTime.parse(widget.paydate.toString());
    if (date.isBefore(DateTime.now())) {
      timeColor = Colors.red;
    } else {
      timeColor = Colors.black;
    }
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
                    "MEMBER ID: ${widget.ID.toString()}",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  Text(
                    widget.name.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  Text(
                    widget.phoneNumber.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0),
                  ),
                  Text(
                    'Pay Date: ${widget.paydate}',
                    style: TextStyle(
                        color: timeColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0),
                  ),
                  Text(
                    'Fee: Rs. ${widget.fee}',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0),
                  ),
                ],
              ),
              Flexible(
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  tooltip: 'More Details',
                  onPressed: () => {},
                ),
              ),
            ],
          ),
          Divider(color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.call,
                      color: Colors.teal,
                    ),
                    tooltip: 'Call Member',
                    onPressed:widget.func1,
                  ),
                  Text(
                    'Call',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.message,
                      color: Colors.teal,
                    ),
                    tooltip: 'Message Member',
                    onPressed: widget.func2,
                  ),
                  Text(
                    'Message',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.money,
                      color: Colors.teal,
                    ),
                    tooltip: 'Renew Fees',
                    onPressed:  widget.func3,
                  ),
                  Text(
                    'Renew',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    tooltip: 'Delete Member',
                    onPressed:  widget.func4,
                  ),
                  Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

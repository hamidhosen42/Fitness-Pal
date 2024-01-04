// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class CustomCardRE extends StatelessWidget {
  final String? imagePath;
  final String? type;
  final Function? add;
  final Function? view;
  CustomCardRE({this.imagePath, this.type, this.add, this.view});
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
        children: [
          Image.asset(
            imagePath.toString(),
            width: 84.0,
          ),
          Text(
            type.toString(),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(TColor.secondaryColor),
            ),
            onPressed: () => view,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.list_alt,
                  color: Colors.white,
                  size: 40.0,
                ),
                Text(
                  'View $type',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(TColor.secondaryColor),
            ),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(18.0),
            // ),
            onPressed: () => add,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 40.0,
                ),
                Text(
                  'Add New $type',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
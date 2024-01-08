// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final List<Widget> horizontalList;
  final String? title;

  Section({this.title, required this.horizontalList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35.0),
      child: Column(
        children: [
          SectionTitle(title.toString()),
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 20.0, top: 10.0),
            scrollDirection: Axis.horizontal,
            child: Row(
                children: (horizontalList != null ) ? horizontalList : []
                ),
          )
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
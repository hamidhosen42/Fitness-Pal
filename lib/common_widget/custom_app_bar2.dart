// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import '../common/colo_extension.dart';

class CustomAppBar2 extends StatelessWidget {
  final IconData icon;
  final String screenTitle;
  final Function func;
  CustomAppBar2(this.icon, this.func, this.screenTitle);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: TColor.secondaryColor,
      elevation: 0.0,
      title: Text(screenTitle),
      leading: IconButton(
        icon: Icon(icon),
        iconSize: 28.0,
        onPressed: () {},
      ),
      // actions: [
      //   IconButton(
      //     icon: const Icon(Icons.notifications_none),
      //     iconSize: 28.0,
      //     onPressed: () {},
      //   ),
      // ],
    );
  }
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
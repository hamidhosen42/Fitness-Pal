// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class CutomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final bool? secured;
  final Widget? suffixIcon;
  final bool? isRequired;
  final TextEditingController? controller;
  final String icon;
  final EdgeInsets? margin;
  const CutomTextField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.secured,
    this.suffixIcon,
    this.isRequired,
    this.controller,
    required this.icon,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: TColor.lightGray, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: secured ?? false,
        validator: isRequired == true
            ? (value) {
                if (value!.isEmpty) {
                  return "The Field is required";
                }
                return null;
              }
            : null,
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(color: TColor.gray, fontSize: 12),
          filled: true,
          suffixIcon: suffixIcon,
          prefixIcon: Container(
              alignment: Alignment.center,
              width: 20,
              height: 20,
              child: Image.asset(
                icon,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
                color: TColor.gray,
              )),
        ),
      ),
    );
  }
}

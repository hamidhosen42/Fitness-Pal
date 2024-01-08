
import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final String icon;
  final Widget? rigtIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  final bool? isRequired;
  final bool? secured;
    final Widget? suffixIcon;
  const RoundTextField({super.key, required this.hitText, required this.icon, this.controller, this.margin, this.keyboardType, this.obscureText = false , this.rigtIcon,this.isRequired,    this.secured,    this.suffixIcon, });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: TColor.lightGray, borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: isRequired == true
            ? (value) {
                if (value!.isEmpty) {
                  return "The Field is required";
                }
                return null;
              }
            : null,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hitText,
            suffixIcon: rigtIcon,
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
            hintStyle: TextStyle(color: TColor.gray, fontSize: 12)),
      ),
    );
  }
}
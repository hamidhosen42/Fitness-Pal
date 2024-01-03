// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../common/colo_extension.dart';
import 'round_button.dart';

class CustomButton extends StatelessWidget {
  final RoundButtonType type;
  final String btnTitle;
  final void Function()? onTap;
  final bool? isLoading;
  const CustomButton(
      {required this.btnTitle, this.onTap, this.isLoading, this.type = RoundButtonType.bgGradient,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: type == RoundButtonType.bgSGradient ? TColor.secondaryG :  TColor.primaryG,
              ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: type == RoundButtonType.bgGradient ||  type == RoundButtonType.bgSGradient 
              ? const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.5,
                      offset: Offset(0, 0.5))
                ]
              : null),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Center(
            child: isLoading == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white,),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        btnTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                : Text(
                    btnTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ),
      ),
    );
  }
}
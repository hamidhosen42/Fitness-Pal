// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:fitness/view/drawer.dart';
import 'package:flutter/material.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/custom_card_re.dart';
import 'add_expense.dart';
import 'add_income.dart';
import 'view_expense.dart';
import 'view_income.dart';

class IncExpScreen extends StatefulWidget {
  @override
  _IncExpScreenState createState() => _IncExpScreenState();
}

class _IncExpScreenState extends State<IncExpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
        backgroundColor: TColor.secondaryColor,
        elevation: 0.0,
        title: Text('Revenue & Expenses'),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomCardRE(
                  imagePath:
                      'assets/images/increase_presentation_Profit_growth-512.png',
                  type: 'Incomes',
                  view: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewIncome(),
                      ),
                    ),
                  },
                  add: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddIncome(),
                      ),
                    ),
                  },
                ),
                CustomCardRE(
                  imagePath:
                      'assets/images/decrease_presentation_down_loss-512.png',
                  type: 'Expenses',
                  view: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewExpense(),
                      ),
                    ),
                  },
                  add: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddExpense(),
                      ),
                    ),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
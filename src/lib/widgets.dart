// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:xpense/constants.dart';
import 'package:xpense/screens/home/budgetpage.dart';

class BudgetCardWidget extends StatelessWidget {
  final String title;
  final String budgetAmount;
  BudgetCardWidget({required this.title, required this.budgetAmount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BudgetPage(),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 5.0,
          bottom: 30.0,
          left: 20.0,
          right: 5.0,
        ),
        margin: EdgeInsets.only(
          bottom: 20.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          gradient: LinearGradient(colors: [seaGreen, seaGreen, darkerGreen]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )),
              ],
            ),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '\$' + budgetAmount,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PurchaseCardWidget extends StatelessWidget {
  final String? type;
  final String? date;
  final String? totalAmount;
  final String? title;
  final IconData? icon;
  PurchaseCardWidget(
      {this.type, this.date, this.totalAmount, this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 25.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(
        bottom: 15.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: seaGreen,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 5.0,
                    ),
                    child: Text(
                      type ?? 'other',
                      style: TextStyle(
                          color: seaGreen,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    date ?? '(unknown)',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: flatGray,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 2,
              ),
              child: Text(
                title ?? '(unknown)',
                style: TextStyle(
                  color: flatGray,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
              ),
              child: Text(
                '\$' + totalAmount.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: darkGray,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeadingWidget extends StatelessWidget {
  final String headingText;
  HeadingWidget({required this.headingText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        bottom: 10,
      ),
      child: Text(
        headingText,
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color: darkGray,
        ),
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Future<void> showMyDialog(
    String title, String bodyText, BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(bodyText),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'OK',
              style: TextStyle(color: seaGreen),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

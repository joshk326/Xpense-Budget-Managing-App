import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:xpense/constants.dart';

import '../../functions.dart';
import '../../models/budget.dart';
import '../database_helper.dart';

class BudgetPage extends StatefulWidget {
  @override
  _BudgetPage createState() => _BudgetPage();
}

class _BudgetPage extends State<BudgetPage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  int? _budgetID = 0;
  String? _budgetStartDate = '';
  String? _budgetEndDate = '';
  String? _budgetAmount = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Enter Budget Amount',
                  style: TextStyle(
                    color: flatGray,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          hintText: '\$0.00', border: OutlineInputBorder()),
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                      onSubmitted: (value) async {
                        if (value != '') {
                          NewBudget _newBudget = NewBudget(
                            amount: value,
                          );
                          _budgetID = await _dbHelper.insertBudget(_newBudget);
                          setState(() {
                            _budgetAmount = value;
                          });
                        }
                      },
                    )),
                  ],
                ),
              ),
              MaterialButton(onPressed: () {
                print('Button Pressed');
              }),
            ],
          ),
        ),
      ),
    );
  }
}

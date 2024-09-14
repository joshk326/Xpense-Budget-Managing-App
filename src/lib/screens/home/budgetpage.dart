import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xpense/constants.dart';
import '../../models/budget.dart';
import '../database_helper.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  _BudgetPage createState() => _BudgetPage();
}

class _BudgetPage extends State<BudgetPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  int? _budgetID = 0;
  final String? _budgetStartDate = '';
  final String? _budgetEndDate = '';
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
                      child: const Padding(
                        padding: EdgeInsets.all(25.0),
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
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
                      decoration: const InputDecoration(
                          hintText: '\$0.00', border: OutlineInputBorder()),
                      style: const TextStyle(
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
                if (kDebugMode) {
                  print('Button Pressed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

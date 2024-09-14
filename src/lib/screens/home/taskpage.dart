import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:xpense/constants.dart';
import 'package:xpense/models/transaction.dart';
import 'package:xpense/screens/database_helper.dart';
import 'package:xpense/widgets.dart';

import '../../functions.dart';

class TaskPage extends StatefulWidget {
  final NewTransaction? transaction;
  const TaskPage({super.key, required this.transaction});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  int? _transactionID = 0;
  String? _transactionTitle = '';
  String? _transactionAmount = '';
  String? _transactionDate = '';
  String? _transactionCategory = '';
  String? _selectedColor;

  late FocusNode _titleFocus;
  late FocusNode _amountFocus;
  late FocusNode _dateFocus;

  bool _contentVisible = false;

  DateTime? _selectedDate;

  final List<String> _dropDownValues = [
    "Groceries",
    "Food",
    "Shopping",
    "Bill",
    "Other"
  ];

  IconData selectedIcon(String value) {
    if (value == 'Groceries') {
      return Icons.local_grocery_store;
    } else if (value == 'Food') {
      return Icons.dinner_dining;
    } else if (value == 'Shopping') {
      return Icons.shopping_bag;
    } else if (value == 'Bill') {
      return Icons.receipt;
    } else {
      return Icons.more_horiz;
    }
  }

  @override
  void initState() {
    if (widget.transaction != null) {
      _contentVisible = true;
      _transactionTitle = widget.transaction!.title;
      _transactionAmount = widget.transaction!.amount;
      _transactionDate = widget.transaction!.date;
      _transactionCategory = widget.transaction!.category;
      _transactionID = widget.transaction!.id;
    }

    _titleFocus = FocusNode();
    _amountFocus = FocusNode();
    _dateFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _amountFocus.dispose();
    _dateFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: HeadingWidget(
                          headingText: 'Transaction Details',
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 20, top: 55),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              'Title',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: flatGray),
                            ),
                          ),
                          TextField(
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              if (value != '') {
                                if (widget.transaction == null) {
                                  NewTransaction _newTran = NewTransaction(
                                    title: value,
                                  );
                                  _transactionID = await _dbHelper
                                      .insertTransaction(_newTran);
                                  setState(() {
                                    _contentVisible = true;
                                    _transactionTitle = value;
                                  });
                                } else {
                                  _dbHelper.updateTransactionTitle(
                                      _transactionID!, value);
                                }
                                _amountFocus.requestFocus();
                              }
                            },
                            controller: TextEditingController()
                              ..text = _transactionTitle!,
                            decoration: const InputDecoration(
                              hintText: 'Ex. Electric Bill',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: seaGreen),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Visibility(
                            visible: _contentVisible,
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 5, top: 20),
                              child: Text(
                                'Transaction Amount',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: flatGray),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _contentVisible,
                            child: TextField(
                              focusNode: _amountFocus,
                              onSubmitted: (value) async {
                                if (_transactionID != 0) {
                                  if (isNumeric(value)) {
                                    await _dbHelper.updateTransactionAmount(
                                        _transactionID!, value);
                                    _transactionAmount = value;
                                    setState(() {});
                                    _dateFocus.requestFocus();
                                  } else {
                                    showMyDialog(
                                        'Incorrect Input',
                                        'Transaction amount can only contain numbers.',
                                        context);
                                  }
                                }
                              },
                              decoration: const InputDecoration(
                                hintText: '0.00',
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  borderSide:
                                      BorderSide(width: 1, color: seaGreen),
                                ),
                              ),
                              controller: TextEditingController()
                                ..text = _transactionAmount ?? '0.00',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _contentVisible,
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 5, top: 15),
                              child: Text(
                                'Category',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: flatGray),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _contentVisible,
                            child: Container(
                              width: 400,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 15),
                              decoration: BoxDecoration(
                                  color: seaGreen,
                                  borderRadius: BorderRadius.circular(10)),
                              child: DropdownButton<String>(
                                onChanged: (value) {
                                  setState(() {
                                    _selectedColor = value;
                                  });
                                },
                                value: _selectedColor,
                                underline: Container(),
                                hint: const Center(
                                    child: Text(
                                  'Select Category',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                                icon: const Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                ),
                                isExpanded: true,
                                items: _dropDownValues
                                    .map((e) => DropdownMenuItem(
                                          onTap: () {
                                            category = e;
                                            _dbHelper.updateTransactionCategory(
                                                _transactionID!,
                                                category.toString());
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              e,
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                          value: e,
                                        ))
                                    .toList(),
                                selectedItemBuilder: (BuildContext context) =>
                                    _dropDownValues
                                        .map((e) => Center(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    selectedIcon(e),
                                                    color: Colors.white,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10.0,
                                                    ),
                                                    child: Text(
                                                      e,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _contentVisible,
                            child: const Padding(
                              padding: EdgeInsets.only(bottom: 5, top: 20),
                              child: Text(
                                'Date',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: flatGray),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _contentVisible,
                            child: DatePickerWidget(
                              looping: false, // default is not looping
                              firstDate: DateTime(1990, 01, 01),
                              lastDate: DateTime(2130, 01, 01),
                              initialDate: DateTime(
                                  dateYear(_transactionDate != null
                                      ? _transactionDate!
                                      : ''),
                                  dateMonth(_transactionDate != null
                                      ? _transactionDate!
                                      : ''),
                                  dateDay(_transactionDate != null
                                      ? _transactionDate!
                                      : '')),
                              dateFormat: "dd-MMM-yyyy",
                              locale: DatePicker.localeFromString('en'),
                              onChange: (DateTime newDate, _) async {
                                if (_transactionID != 0) {
                                  _selectedDate = newDate;
                                  String dateSelected = _selectedDate
                                      .toString()
                                      .replaceAll(' 00:00:00.000', '');
                                  await _dbHelper.updateTransactionDate(
                                      _transactionID!, dateSelected);
                                  _transactionDate = dateSelected;
                                }
                              },
                              pickerTheme: const DateTimePickerTheme(
                                itemTextStyle:
                                    TextStyle(color: darkGray, fontSize: 19),
                                dividerColor: seaGreen,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
                visible: _contentVisible,
                child: Positioned(
                  bottom: 60.0,
                  right: 30,
                  child: GestureDetector(
                    onTap: () async {
                      if (_transactionID != 0) {
                        await _dbHelper.deleteTransaction(_transactionID!);
                        setState(() {});
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        gradient: const LinearGradient(
                            colors: [thunderBirdHue, thunderBird]),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

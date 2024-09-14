import 'package:flutter/material.dart';
import 'package:xpense/screens/database_helper.dart';
import 'package:xpense/screens/home/taskpage.dart';
import '../../constants.dart';
import '../../widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _searchBarVisibile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 25.0,
            vertical: 5.0,
          ),
          color: themeBackground,
          child: Stack(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 5.0,
                  ),
                  child: const Image(
                    image: AssetImage('assets/images/logo_small.png'),
                    height: 60,
                    width: 40,
                  ),
                ),
                BudgetCardWidget(
                    title: 'Current Budget:', budgetAmount: '0.00'),
                Row(
                  children: [
                    HeadingWidget(
                      headingText: 'Transactions',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 7.0, left: 130),
                      child: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: darkGray,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_searchBarVisibile) {
                              _searchBarVisibile = false;
                            } else {
                              _searchBarVisibile = true;
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: _searchBarVisibile,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                    child: TextField(
                      onChanged: (value) {}, //=> _runFilter(value),
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        labelStyle: TextStyle(color: flatGray),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(width: 1, color: seaGreen),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    initialData: [],
                    future: _dbHelper.getTransaction(),
                    builder: (context, AsyncSnapshot snapshot) {
                      return ScrollConfiguration(
                        behavior: NoGlowBehavior(),
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TaskPage(
                                            transaction:
                                                snapshot.data[index])));
                              },
                              child: PurchaseCardWidget(
                                title: snapshot.data[index].title,
                                type: snapshot.data[index].category,
                                date: snapshot.data[index].date,
                                totalAmount: snapshot.data[index].amount,
                                icon: transactionIcon(
                                    snapshot.data[index].category),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ]),
              Positioned(
                bottom: 10.0,
                right: 0.0,
                child: Opacity(
                  opacity: 0.6,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskPage(transaction: null),
                        ),
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: darkGray,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: seaGreen,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

IconData transactionIcon(String? value) {
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

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xpense/models/budget.dart';

import '../models/transaction.dart';

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'transactions_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE transactions(id INTEGER PRIMARY KEY, title TEXT, date TEXT, category TEXT, amount TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<Database> database2() async {
    return openDatabase(
      join(await getDatabasesPath(), 'transactions_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE budget(id INTEGER PRIMARY KEY, budgetamount TEXT, startdate TEXT, enddate TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<int> insertBudget(NewBudget budget) async {
    int id = 0;
    Database _db = await database2();
    await _db
        .insert('budget', budget.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      id = value;
    });
    return id;
  }

  Future<void> updateBudgetAmount(int id, String amount) async {
    Database _db = await database2();
    _db.rawUpdate("UPDATE budget SET amount = '$amount' WHERE id = $id");
  }

  Future<List<NewTransaction>> getBudget() async {
    Database _db = await database();
    List<Map<String, dynamic>> transactionMap = await _db.query('transactions');
    return List.generate(transactionMap.length, (index) {
      return NewTransaction(
          id: transactionMap[index]['id'],
          title: transactionMap[index]['title'],
          date: transactionMap[index]['date'],
          category: transactionMap[index]['category'],
          amount: transactionMap[index]['amount']);
    });
  }

  Future<int> insertTransaction(NewTransaction transaction) async {
    int id = 0;
    Database _db = await database();
    await _db
        .insert('transactions', transaction.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      id = value;
    });
    return id;
  }

  Future<void> updateTransactionTitle(int id, String title) async {
    Database _db = await database();
    _db.rawUpdate("UPDATE transactions SET title = '$title' WHERE id = $id");
  }

  Future<void> updateTransactionAmount(int id, String amount) async {
    Database _db = await database();
    _db.rawUpdate("UPDATE transactions SET amount = '$amount' WHERE id = $id");
  }

  Future<void> updateTransactionDate(int id, String date) async {
    Database _db = await database();
    _db.rawUpdate("UPDATE transactions SET date = '$date' WHERE id = $id");
  }

  Future<void> updateTransactionCategory(int id, String category) async {
    Database _db = await database();
    _db.rawUpdate(
        "UPDATE transactions SET category = '$category' WHERE id = $id");
  }

  Future<List<NewTransaction>> getTransaction() async {
    Database _db = await database();
    List<Map<String, dynamic>> transactionMap = await _db.query('transactions');
    return List.generate(transactionMap.length, (index) {
      return NewTransaction(
          id: transactionMap[index]['id'],
          title: transactionMap[index]['title'],
          date: transactionMap[index]['date'],
          category: transactionMap[index]['category'],
          amount: transactionMap[index]['amount']);
    });
  }

  Future<void> deleteTransaction(int id) async {
    Database _db = await database();
    await _db.rawDelete("DELETE FROM transactions WHERE id = '$id'");
  }
}

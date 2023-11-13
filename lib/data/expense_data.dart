import 'package:expense_app/data/hive_database.dart';
import 'package:expense_app/models/expense_model.dart';
import 'package:expense_app/shared/components/functions.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
//list
  List<ExpenseModel> overallExpanses = [];
  List<ExpenseModel> get allExpenses => overallExpanses;
  final HiveDAtaBase _db = HiveDAtaBase();
//add
  void addNewExpense(ExpenseModel newExpense) {
    overallExpanses.add(newExpense);
    _db.saveData(overallExpanses);
    notifyListeners();
  }

//delete
  void deleteExpenses(ExpenseModel expense) {
    overallExpanses.remove(expense);
    notifyListeners();
    _db.saveData(overallExpanses);
  }

//get weekday from data time object
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wen";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return '';
    }
  }

//get the date for the start of the week
  DateTime get startOfTheWeekDate {
    /* ---> default sunday */
    //get nearest sunday
    DateTime today = DateTime.now();
    late DateTime startOfTheWeek;
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == "Sun") {
        startOfTheWeek = today.subtract(Duration(days: i));
        break;
      }
    }
    //returns the date of nears Sunday (the start day of the week)
    return startOfTheWeek;
  }

// display expenses by day
  Map<String, double> calculateDailyExpenses() {
    Map<String, double> dailyExpenses = {
      //date (dd-mm-yyyy):overall day expenses
    };
    for (var expense in overallExpanses) {
      String date = convertDateTimeToString(expense.date);
      double amount = double.parse(expense.amount);
      if (dailyExpenses.containsKey(date)) {
        double currentAmount = dailyExpenses[date]!;
        dailyExpenses[date] = currentAmount + amount;
      } else {
        dailyExpenses[date] = amount;
      }
    }
    return dailyExpenses;
  }

//prepare data
  void prepareData() =>
      overallExpanses = _db.readData().isNotEmpty ? _db.readData() : [];
}

import 'package:hive/hive.dart';

import '../models/expense_model.dart';

class HiveDAtaBase {
  //init database
  final _myBox = Hive.box("expense_database");
  // wire database
  void saveData(List<ExpenseModel> allExpenseModels) {
    List<List<dynamic>> allExpenses = [];
    for (var expense in allExpenseModels) {
      allExpenses.add([expense.name, expense.amount, expense.date]);
    }
    _myBox.put("ALL_EXPENSES", allExpenses);
  }

  //read database
  List<ExpenseModel> readData() {
    List savedExpensesHive = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseModel> savedExpenses = [];
    for (int i = 0; i < savedExpensesHive.length; i++) {
      String name = savedExpensesHive[i][0];
      String amount = savedExpensesHive[i][1];
      DateTime date = savedExpensesHive[i][2];
      ExpenseModel expenseModel = ExpenseModel(
        name: name,
        amount: amount,
        date: date,
      );
      savedExpenses.add(expenseModel);
    }
    return savedExpenses;
  }
}

import 'package:expense_app/data/expense_data.dart';
import 'package:expense_app/models/expense_model.dart';
import 'package:expense_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/expense_summary.dart';
import 'components/expense_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _expenseController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void addNewExpenses() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // contentPadding: EdgeInsets.symmetric(horizontal: 8),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        backgroundColor: Colors.grey[300],
        actions: [
          MaterialButton(
            onPressed: save,
            child: const Text("save"),
          ),
          MaterialButton(
            onPressed: cancel,
            child: const Text("cancel"),
          ),
        ],
        title: const Center(child: Text("Add new expense")),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            defaultTextFormField(
              controller: _expenseController,
              hint: "Expense",
              type: TextInputType.name,
            ),
            const SizedBox(height: 10),
            defaultTextFormField(
              controller: _amountController,
              hint: "Amount",
              type: TextInputType.number,
              prefix: Icons.monetization_on_outlined,
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  void deleteExpenses(ExpenseModel expense) {
    Provider.of<ExpenseData>(listen: false, context).deleteExpenses(expense);
  }

  void save() {
    if (_amountController.text.isNotEmpty &&
        _expenseController.text.isNotEmpty) {
      ExpenseModel newExpense = ExpenseModel(
        name: _expenseController.text,
        amount: _amountController.text,
        date: DateTime.now(),
      );
      Provider.of<ExpenseData>(listen: false, context)
          .addNewExpense(newExpense);
      clearControllers();
    }
    Navigator.pop(context);
  }

  void cancel() {
    clearControllers();
    Navigator.pop(context);
  }

  void clearControllers() {
    _expenseController.clear();
    _amountController.clear();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (BuildContext context, ExpenseData expenseData, Widget? child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.grey[300],
            floatingActionButton: FloatingActionButton(
              onPressed: addNewExpenses,
              backgroundColor: Colors.black,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                ExpenseSummary(
                  startOfTheWeek: expenseData.startOfTheWeekDate,
                ),

                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        height: 0,
                        thickness: 1,
                        endIndent: 10,
                      ),
                    ),
                    Text("Your Expanses"),
                    Expanded(
                      child: Divider(
                        height: 0,
                        thickness: 1,
                        indent: 10,
                      ),
                    ),
                  ],
                ),

                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: expenseData.allExpenses.length,
                  itemBuilder: (context, index) => ExpenseTile(
                    name: expenseData.allExpenses[index].name,
                    amount: expenseData.allExpenses[index].amount,
                    date: expenseData.allExpenses[index].date,
                    onPressed: (p0) =>
                        deleteExpenses(expenseData.allExpenses[index]),
                  ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    height: 0,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

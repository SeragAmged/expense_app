import 'package:expense_app/modules/home/components/bargraph/bar_graph.dart';
import 'package:expense_app/data/expense_data.dart';
import 'package:expense_app/shared/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfTheWeek;
  const ExpenseSummary({super.key, required this.startOfTheWeek});

  @override
  Widget build(BuildContext context) {
    String sunday =
        startOfTheWeek.add(const Duration(days: 0)).convertToString();
    String monday =
        startOfTheWeek.add(const Duration(days: 1)).convertToString();
    String tuesday =
        startOfTheWeek.add(const Duration(days: 2)).convertToString();
    String wednesday =
        startOfTheWeek.add(const Duration(days: 3)).convertToString();
    String thursday =
        startOfTheWeek.add(const Duration(days: 4)).convertToString();
    String friday =
        startOfTheWeek.add(const Duration(days: 5)).convertToString();
    String saturday =
        startOfTheWeek.add(const Duration(days: 6)).convertToString();

    return Consumer<ExpenseData>(
      builder: (context, ExpenseData expenseData, child) {
        double sunAmount = expenseData.calculateDailyExpenses()[sunday] ?? 0;
        double monAmount = expenseData.calculateDailyExpenses()[monday] ?? 0;
        double tueAmount = expenseData.calculateDailyExpenses()[tuesday] ?? 0;
        double wedAmount = expenseData.calculateDailyExpenses()[wednesday] ?? 0;
        double thuAmount = expenseData.calculateDailyExpenses()[thursday] ?? 0;
        double friAmount = expenseData.calculateDailyExpenses()[friday] ?? 0;
        double satAmount = expenseData.calculateDailyExpenses()[saturday] ?? 0;
        double total = sunAmount +
            monAmount +
            tueAmount +
            wedAmount +
            thuAmount +
            friAmount +
            satAmount;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  const Text(
                    "Week Total: ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("\$$total"),
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: MyBarGraph(
                sunAmount: sunAmount,
                monAmount: monAmount,
                tueAmount: tueAmount,
                wedAmount: wedAmount,
                thuAmount: thuAmount,
                friAmount: friAmount,
                satAmount: satAmount,
              ),
            ),
          ],
        );
      },
    );
  }
}

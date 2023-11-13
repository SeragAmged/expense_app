import 'package:expense_app/shared/components/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime date;

  final void Function(BuildContext)? onPressed;
  const ExpenseTile({
    super.key,
    required this.onPressed,
    required this.name,
    required this.amount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(), children: [
        SlidableAction(
          onPressed: onPressed,
          backgroundColor: Colors.red,
          borderRadius: BorderRadius.circular(4),
          icon: Icons.delete,
        )
      ]),
      child: ListTile(
        title: Text(name),
        subtitle: Text(date.convertToString()),
        trailing: Text("\$$amount"),
      ),
    );
  }
}

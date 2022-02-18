import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../models/transaction.dart";
import "./chart_bar.dart";

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);
  
  List<Map<String, Object>> get groupedTransactions { // Map<(key), (property)>
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var sumOfTransactions = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        final el = recentTransaction[i];

        if (el.date.day == weekDay.day && el.date.month == weekDay.month && el.date.year == weekDay.year) {
          sumOfTransactions += el.value;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "value": sumOfTransactions
      };
    });
  }

  double get totalSpending {
    return groupedTransactions.fold(0.0, (sum, element) {
      return sum + element["value"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((transaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                transaction['day'],
                transaction['value'],
                totalSpending == 0.0 ? 0.0 : (transaction["value"] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
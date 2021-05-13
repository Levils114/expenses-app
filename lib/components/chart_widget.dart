import 'package:expenses/components/chart_bar_widget.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatelessWidget {
  final List<Transaction> recentTransaction;

  ChartWidget({@required this.recentTransaction});

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _totalValue {
    return groupedTransaction.fold(0,
        (previousValue, transaction) => previousValue + transaction['value']);
  }

  @override
  Widget build(BuildContext context) {
    return (Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction
              .map((transaction) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBarWidget(
                      percentage: _totalValue == 0
                          ? 0
                          : (transaction['value'] as double) / _totalValue,
                      value: transaction['value'],
                      label: transaction['day'],
                    ),
                  ))
              .toList(),
        ),
      ),
    ));
  }
}

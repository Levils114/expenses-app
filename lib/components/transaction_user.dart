import 'dart:math';

import 'package:expenses/components/transaction_form_widget.dart';
import 'package:expenses/components/transaction_list_widget.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  @override
  State createState() {
    return (TransactionUserState());
  }
}

class TransactionUserState extends State {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Camisa Santos 21/22',
      value: 250.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Camisa Santos 21/22',
      value: 250.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Camisa Santos 21/22',
      value: 250.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Camisa Santos 21/22',
      value: 250.00,
      date: DateTime.now(),
    ),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        TransactionFormWidget(
          addTransactionFunction: _addTransaction,
        ),
        TransactionListWidget(
          transactions: _transactions,
        ),
      ],
    ));
  }
}

import 'package:expenses/components/transaction_item_widget.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) removeTransactionFunction;

  TransactionListWidget(
      {this.transactions, @required this.removeTransactionFunction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.02,
                ),
                Container(
                  height: constraints.maxHeight * 0.1,
                  child: Text(
                    'Nenhuma Transação Cadastrada!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.02,
                ),
                Container(
                  height: constraints.maxHeight * 0.5,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        : (ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) => TransactionItemWidget(
              removeTransactionFunction: removeTransactionFunction,
              transactions: transactions,
              index: index,
              key: GlobalObjectKey(transactions[index]),
            ),
          ));
  }
}

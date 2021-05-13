import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListWidget extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) removeTransactionFunction;

  TransactionListWidget(
      {this.transactions, @required this.removeTransactionFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390,
      child: transactions.isEmpty
          ? (Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Nenhuma Transação Cadastrada!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ))
          : (ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) => Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                            'R\$ ${transactions[index].value.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('dd MMM y').format(transactions[index].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () =>
                        removeTransactionFunction(transactions[index].id),
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ),
            )),
    );
  }
}

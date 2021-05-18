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
            itemBuilder: (context, index) => Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(
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
                trailing: MediaQuery.of(context).size.width <= 400
                    ? IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            removeTransactionFunction(transactions[index].id),
                        color: Theme.of(context).errorColor,
                      )
                    : TextButton.icon(
                        onPressed: () =>
                            removeTransactionFunction(transactions[index].id),
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        label: Text(
                          'Excluir',
                          style: TextStyle(
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                      ),
              ),
            ),
          ));
  }
}

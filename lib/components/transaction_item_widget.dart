import 'dart:math';

import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItemWidget extends StatefulWidget {
  final List<Transaction> transactions;
  final int index;
  final void Function(String) removeTransactionFunction;

  TransactionItemWidget({
    Key key,
    this.transactions,
    this.index,
    this.removeTransactionFunction,
  }) : super(key: key);

  @override
  _TransactionItemWidgetState createState() => _TransactionItemWidgetState();
}

class _TransactionItemWidgetState extends State<TransactionItemWidget> {
  static const colors = [
    Colors.black,
    Colors.purple,
    Colors.blue,
    Colors.orange,
    Colors.yellow,
  ];

  Color _backgroundColor;

  @override
  void initState() {
    int backgroundColorNumber = Random().nextInt(colors.length);
    _backgroundColor = colors[backgroundColorNumber];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                  'R\$ ${widget.transactions[widget.index].value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          widget.transactions[widget.index].title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd MMM y').format(widget.transactions[widget.index].date),
        ),
        trailing: MediaQuery.of(context).size.width <= 400
            ? IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => widget.removeTransactionFunction(
                    widget.transactions[widget.index].id),
                color: Theme.of(context).errorColor,
              )
            : TextButton.icon(
                onPressed: () => widget.removeTransactionFunction(
                    widget.transactions[widget.index].id),
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
    ));
  }
}

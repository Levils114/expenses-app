import 'package:flutter/material.dart';

class TransactionFormWidget extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double) addTransactionFunction;

  TransactionFormWidget({@required this.addTransactionFunction});

  @override
  Widget build(BuildContext context) {
    return (Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Título'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Valor (R\$)'),
              controller: valueController,
              keyboardType: TextInputType.number,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  addTransactionFunction(
                    titleController.text,
                    double.tryParse(valueController.text) ?? 0.0,
                  );
                },
                child: Text(
                  'Nova Transação',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

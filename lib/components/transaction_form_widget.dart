import 'package:flutter/material.dart';

class TransactionFormWidget extends StatefulWidget {
  final void Function(String, double) addTransactionFunction;

  TransactionFormWidget({@required this.addTransactionFunction});

  @override
  _TransactionFormWidgetState createState() => _TransactionFormWidgetState();
}

class _TransactionFormWidgetState extends State<TransactionFormWidget> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  final FocusNode valueTextfieldFocus = FocusNode();

  _submitForm() {
    if (titleController.text.isEmpty || valueController.text.isEmpty) {
      return;
    }

    widget.addTransactionFunction(
      titleController.text,
      double.tryParse(valueController.text) ?? 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: (Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Título'),
                onSubmitted: (String _) => valueTextfieldFocus.requestFocus(),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
                controller: valueController,
                focusNode: valueTextfieldFocus,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (String _) => _submitForm(),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _submitForm,
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
      )),
    );
  }
}

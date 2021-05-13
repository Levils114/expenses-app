import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionFormWidget extends StatefulWidget {
  final void Function(String, double, DateTime) addTransactionFunction;

  TransactionFormWidget({@required this.addTransactionFunction});

  @override
  _TransactionFormWidgetState createState() => _TransactionFormWidgetState();
}

class _TransactionFormWidgetState extends State<TransactionFormWidget> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  final FocusNode valueTextfieldFocus = FocusNode();

  _submitForm() {
    if (_titleController.text.isEmpty ||
        _valueController.text.isEmpty ||
        _selectedDate == null) {
      return;
    }

    widget.addTransactionFunction(
      _titleController.text,
      double.tryParse(_valueController.text) ?? 0.0,
      _selectedDate,
    );
  }

  _showDatePicker() async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = pickedDate;
    });
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
                controller: _titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
                controller: _valueController,
                focusNode: valueTextfieldFocus,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (String _) => _submitForm(),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(_selectedDate != null
                        ? 'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'
                        : 'Nenhuma data selecionada!'),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    'Nova Transação',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.button.color,
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

import 'package:expenses/components/adaptative_button_widgtet.dart';
import 'package:expenses/components/adaptative_textfield_widget.dart';
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

  final FocusNode titleTextfieldFocus = FocusNode();
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
              AdaptativeTextfieldWidget(
                controller: _titleController,
                keyboardType: TextInputType.name,
                focusNode: titleTextfieldFocus,
                label: InputDecoration(labelText: 'Título'),
                placeholder: 'Título',
                onSubmit: (String _) => valueTextfieldFocus.requestFocus(),
              ),
              AdaptativeTextfieldWidget(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                focusNode: valueTextfieldFocus,
                label: InputDecoration(labelText: 'Valor (R\$)'),
                placeholder: 'Valor (R\$)',
                onSubmit: (String _) => _submitForm(),
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
                child: AdapatativeButtonWidget(
                  functionToSubmit: _submitForm(),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

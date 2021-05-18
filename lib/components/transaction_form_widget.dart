import 'package:expenses/components/adaptative_button_widgtet.dart';
import 'package:expenses/components/adaptative_datepicker_widget.dart';
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
                label: 'Título',
                onSubmit: (String _) => valueTextfieldFocus.requestFocus(),
              ),
              AdaptativeTextfieldWidget(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                focusNode: valueTextfieldFocus,
                label: 'Valor (R\$)',
                onSubmit: (String _) => _submitForm(),
              ),
              SizedBox(
                height: 8,
              ),
              AdaptativeDatepickerWidget(
                selectedDate: _selectedDate,
                onDateChange: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
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

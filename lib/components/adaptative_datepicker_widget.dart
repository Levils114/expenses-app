import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeDatepickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  AdaptativeDatepickerWidget({
    this.selectedDate,
    this.onDateChange,
  });

  @override
  Widget build(BuildContext context) {
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

      onDateChange(pickedDate);
    }

    return (Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                child: Text(selectedDate != null
                    ? 'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'
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
          ));
  }
}

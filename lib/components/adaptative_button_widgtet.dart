import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdapatativeButtonWidget extends StatelessWidget {
  final Function functionToSubmit;

  AdapatativeButtonWidget({@required this.functionToSubmit});

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoButton(
            child: Text('Nova Transação'),
            onPressed: functionToSubmit,
            color: Theme.of(context).textTheme.button.color,
            padding: EdgeInsets.symmetric(horizontal: 20),
          )
        : ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
            ),
            onPressed: functionToSubmit,
            child: Text(
              'Nova Transação',
              style: TextStyle(
                color: Theme.of(context).textTheme.button.color,
              ),
            ),
          ));
  }
}

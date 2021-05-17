import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextfieldWidget extends StatelessWidget {
  final InputDecoration label;
  final String placeholder;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final void Function(String) onSubmit;

  AdaptativeTextfieldWidget({
    this.label,
    this.placeholder,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return (Platform.isIOS
        ? CupertinoTextField(
            controller: controller,
            onSubmitted: onSubmit,
            placeholder: placeholder,
            focusNode: focusNode,
            keyboardType: keyboardType,
          )
        : TextField(
            decoration: label,
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            onSubmitted: onSubmit,
          ));
  }
}
